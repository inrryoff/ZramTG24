# ZramTG24 - Turbo Moto G24 Edition (Performance Mode) 🚀

O **ZramTG24** não é um módulo de zRAM genérico. Ele foi projetado **bit por bit** para o hardware do **Moto G24 (fogorow)** e serve como o complemento essencial para o módulo **GameHub**.

## 🔗 Ecossistema GameHub
Enquanto o **GameHub** gerencia os apps e força a parada de processos desnecessários, o **ZramTG24** prepara o sistema:
1. **Limpeza Profunda:** Reseta e limpa a zRAM para entregar memória real, sem "lixo" de apps anteriores.
2. **Entrega de RAM:** Garante que o jogo tenha prioridade total e 4GB de memória virtual (2GB zRAM + 2GB Swapfile) à disposição.
3. **Foco Total:** Trabalham juntos para que o SoC Helio G85 foque 100% na performance do jogo.

## 🛠️ Especificações Técnicas (Exclusivo G24)
- **Combo 4GB Virtual:** 2GB zRAM (LZ4) + 2GB Swapfile em `/data/local/tmp`.
- **CPU Performance:** Força as `policy0` e `policy6` ao máximo para eliminar input lag.
- **I/O Turbinado:** Read-ahead em 4096kb e scheduler `mq-deadline`.
- **Kernel Tweaks:** Ajustes finos de latência calculados especificamente para o G24.

## 📱 Compatibilidade & Software
- **Testado em:** Android 14 (GSI crDroid).
- **Status ROM Stock:** Funcional, porém experimental (em desenvolvimento para correções de bugs específicos da Motorola).
- **Trava de Segurança:** O `install.sh` aborta a instalação se o dispositivo não for o `fogorow`.

> [!CAUTION]
> **AVISO:** Este módulo foca em **PERFORMANCE EXTREMA**. O uso de governors em modo performance e swappiness 100 prioriza a fluidez acima da economia de bateria. Se você modificar o código para forçar a instalação em outro aparelho, o risco é inteiramente seu.

---
**Desenvolvedor:** [@inrryoff](https://github.com/inrryoff)  

**Projeto:** Zram Turbo G24 Gaming
