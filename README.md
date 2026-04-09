# ZramTG24 - Turbo Moto G24 Edition (Performance Mode) 🚀

[![Magisk](https://img.shields.io/badge/Magisk-27.0+-green.svg)](https://github.com/topjohnwu/Magisk)
[![Android](https://img.shields.io/badge/Android-12+-blue.svg)](https://www.android.com)
[![Device](https://img.shields.io/badge/Device-Moto_G24-orange.svg)](https://motorola.com)

---

O **ZramTG24** não é um módulo de zRAM genérico. Ele foi projetado **bit por bit** para o hardware do **Moto G24 (fogorow)** e serve como o complemento essencial para o módulo **GameHub**.

---

## 🔗 Ecossistema GameHub
Enquanto o **GameHub** gerencia os apps e força a parada de processos desnecessários, o **ZramTG24** prepara o sistema:
1. **Limpeza Profunda:** Reseta e limpa a zRAM para entregar memória real, sem "lixo" de apps anteriores.
2. **Entrega de RAM:** Garante que o jogo tenha prioridade total e 4GB de memória virtual (2GB zRAM + 2GB Swapfile) à disposição.
3. **Foco Total:** Trabalham juntos para que o SoC Helio G85 foque 100% na performance do jogo.

---

## 🛠️ Especificações Técnicas (Exclusivo G24)
- **Combo 4GB Virtual:** 2GB zRAM (LZ4) + 2GB Swapfile em `/data/local/tmp`.
- **CPU Performance:** Força as `policy0` e `policy6` ao máximo para eliminar input lag.
- **I/O Turbinado:** Read-ahead em 4096kb e scheduler `mq-deadline`.
- **Kernel Tweaks:** Ajustes finos de latência calculados especificamente para o G24.

---

## 📱 Compatibilidade & Software
- **Testado em:** Moto G24 | Android 14 (GSI crDroid).
- **Status ROM Stock:** Teoricamente funcional, porem ainda em desenvolvimento para correções de bugs específicos da Motorola.
- **Trava de Segurança:** O `customize.sh` aborta a instalação se o dispositivo não for o `fogorow`.

---

### 🔍 Feedback da Comunidade
Se você testar este módulo em:
1. **ROM Stock** (Motorola original).
2. **Moto G24 Power** (Mesmo chipset, bateria maior).
3. Outros dispositivos com **Helio G85**.

Por favor, abra uma *Issue* ou mande seu feedback informando se as frequências ficaram travadas corretamente e como está a estabilidade térmica! 

---

> [!CAUTION]
> **AVISO:** Este módulo foca em **PERFORMANCE EXTREMA**. O uso de governors em modo performance e swappiness 100 prioriza a fluidez acima da economia de bateria. Se você modificar o código para forçar a instalação em outro aparelho, o risco é inteiramente seu.

---

## 👤 Créditos e Licença
* **Desenvolvedor:** [@inrryoff](https://github.com/inrryoff)  
* **Licença:** MIT (Pode usar e modificar, desde que mantenha os créditos ao autor original).
* **Projeto:** Zram Turbo G24 Gaming

