#!/system/bin/sh
LOG_DIR="/data/local/tmp/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/ram_optimize.log"
echo "--- RAM Optimize MT6769 $(date) ---" > "$LOG_FILE"

su -c '
log() { echo "[$(date +%H:%M:%S)] $1" >> '"$LOG_FILE"'; }

log "Iniciando otimização RAM (Thermal OFF mode)"

# 1. Limpeza
sync && echo 3 > /proc/sys/vm/drop_caches 2>/dev/null

# 2. Remover swapfile físico (importante!)
swapoff /data/local/tmp/swapfile 2>/dev/null
rm -f /data/local/tmp/swapfile 2>/dev/null
log "Swapfile físico removido"

# 3. ZRAM configurada agressivamente (com thermal OFF podemos usar mais)
swapoff /dev/block/zram0 2>/dev/null
echo 1 > /sys/block/zram0/reset 2>/dev/null

# Usar melhor compressor disponível
if grep -q "lz4" /sys/block/zram0/comp_algorithm 2>/dev/null; then
    echo lz4 > /sys/block/zram0/comp_algorithm
    log "Compressor lz4 ativado (melhor desempenho)"
fi

# ZRAM de 3GB (75% da RAM, agressivo mas thermal OFF aguenta)
echo 3221225472 > /sys/block/zram0/disksize 2>/dev/null  # 3GB
mkswap /dev/block/zram0 2>/dev/null
swapon /dev/block/zram0 -p 100 2>/dev/null
log "ZRAM: 3GB configurada"

# 4. VM Tweaks (mais agressivos para jogos)
echo 100 > /proc/sys/vm/swappiness  # Mais uso de ZRAM
echo 10 > /proc/sys/vm/vfs_cache_pressure
echo 0 > /proc/sys/vm/page-cluster
echo 16384 > /proc/sys/vm/min_free_kbytes
echo 500 > /proc/sys/vm/dirty_expire_centisecs
echo 5000 > /proc/sys/vm/dirty_writeback_centisecs
echo 25 > /proc/sys/vm/dirty_ratio
echo 15 > /proc/sys/vm/dirty_background_ratio
log "VM tweaks aplicados"

# 5. CPU Governor (performance agora! thermal está OFF)
for policy in /sys/devices/system/cpu/cpufreq/policy*; do
    echo performance > "$policy/scaling_governor" 2>/dev/null
    # Forçar frequência máxima
    max_freq=$(cat "$policy/scaling_max_freq" 2>/dev/null)
    [ -n "$max_freq" ] && echo $max_freq > "$policy/scaling_min_freq" 2>/dev/null
done
log "CPU governor: performance (modo agressivo com thermal OFF)"

# 6. I/O tweaks
for queue in /sys/block/mmcblk*/queue; do
    echo 1024 > "$queue/read_ahead_kb" 2>/dev/null
    echo 0 > "$queue/add_random" 2>/dev/null
    echo 0 > "$queue/iostats" 2>/dev/null
    echo mq-deadline > "$queue/scheduler" 2>/dev/null
done
log "I/O tweaks aplicados"

# 7. Desativar Kernel Samepage Merging (KSM) - Ganha fôlego de CPU
if [ -f /sys/kernel/mm/ksm/run ]; then
    echo 0 > /sys/kernel/mm/ksm/run
    log "KSM desativado (ganho de ciclos de CPU)"
fi

log "RAM otimização concluída (Thermal OFF mode)"
echo "=== RAM otimizada para MT6769 com Thermal OFF ==="
cat /proc/swaps
'