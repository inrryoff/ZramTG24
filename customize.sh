# 1. Verifica o codinome do dispositivo
DEVICE=$(getprop ro.product.device)

case "$DEVICE" in
    fogorow)
        ui_print "✔ Moto G24 detectado!"
    ;;
    *)
        ui_print "❌ Apenas Moto G24 suportado (Detectado: $DEVICE)"
        abort
    ;;
esac

ui_print "- Definindo permissões dos scripts..."
set_perm $MODPATH/ram.sh 0 0 0755
set_perm $MODPATH/service.sh 0 0 0755

