#!/system/bin/sh
LOG_DIR="/data/local/tmp/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/ram_optimize.log"
echo "--- RAM Optimize MT6769 $(date) ---" > "$LOG_FILE"

su -c '
ALGO=${1:-zstd}
MEM_BYTES=3957264384
log() { echo "[$(date +%H:%M:%S)] $1" >> '"$LOG_FILE"'; }
log "Iniciando otimização RAM"

# 1. Remover swapfile físico
swapoff /data/local/tmp/swapfile 2>/dev/null
rm -f /data/local/tmp/swapfile 2>/dev/null
log "Swapfile físico removido"

# 2. ZRAM configurada agressivamente
swapoff /dev/block/zram0 2>/dev/null
echo 1 > /sys/block/zram0/reset 2>/dev/null

if grep -q "$ALGO" /sys/block/zram0/comp_algorithm 2>/dev/null; then
    echo "$ALGO" > /sys/block/zram0/comp_algorithm
    log "Compressor "$ALGO" ativado"
else
    echo lz4 > /sys/block/zram0/comp_algorithm
    log_cmd "Algoritmo $ALGO não suportado, usando lz4"
fi

# ZRAM de 3GB
echo "$MEM_BYTES" > /sys/block/zram0/disksize 2>/dev/null
mkswap /dev/block/zram0 2>/dev/null
swapon /dev/block/zram0 -p 100 2>/dev/null
log "ZRAM: "$MEM_BYTES" configurada"

# 3. VM Tweaks
[ "$ALGO" = "zstd" ] && SWAP_VAL=150 || SWAP_VAL=100
echo $SWAP_VAL > /proc/sys/vm/swappiness
echo 100 > /proc/sys/vm/vfs_cache_pressure
echo 0 > /proc/sys/vm/page-cluster
echo 49152 > /proc/sys/vm/min_free_kbytes
echo 500 > /proc/sys/vm/dirty_expire_centisecs
echo 5000 > /proc/sys/vm/dirty_writeback_centisecs
echo 25 > /proc/sys/vm/dirty_ratio
echo 15 > /proc/sys/vm/dirty_background_ratio
echo 150 > /proc/sys/vm/watermark_scale_factor
log "VM tweaks aplicados"

# 4. I/O tweaks
for queue in /sys/block/mmcblk*/queue; do
    echo 1024 > "$queue/read_ahead_kb" 2>/dev/null
    echo 0 > "$queue/add_random" 2>/dev/null
    echo 0 > "$queue/iostats" 2>/dev/null
    echo mq-deadline > "$queue/scheduler" 2>/dev/null
done
log "I/O tweaks aplicados"

# 5. Desativar Kernel Samepage Merging
if [ -f /sys/kernel/mm/ksm/run ]; then
    echo 0 > /sys/kernel/mm/ksm/run
    log "KSM desativado"
fi

log "RAM otimização concluída"
echo "=== RAM otimizada para Helio G85 ==="
cat /proc/swaps
'