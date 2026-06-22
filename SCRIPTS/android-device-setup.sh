#!/bin/bash
# === Helper para conectar y rootear dispositivos Android ===

ROJO='\033[0;31m'
VERDE='\033[0;32m'
AMARILLO='\033[1;33m'
NC='\033[0m'

echo -e "${VERDE}========================================${NC}"
echo -e "${VERDE}  Android Device Setup Helper${NC}"
echo -e "${VERDE}========================================${NC}"
echo ""

case "${1:-}" in
  usb)
    echo -e "${AMARILLO}[*] Conectando dispositivo por USB...${NC}"
    adb kill-server 2>/dev/null
    adb start-server
    adb wait-for-device
    adb devices
    echo ""
    echo -e "${AMARILLO}[*] Intentando adb root...${NC}"
    adb root
    adb remount
    echo ""
    echo -e "${VERDE}[+] Dispositivo listo:${NC}"
    adb shell "id; su -c id"
    ;;

  tcp)
    IP="${2:-192.168.1.100}"
    echo -e "${AMARILLO}[*] Conectando a $IP:5555...${NC}"
    adb connect "$IP:5555"
    sleep 2
    adb devices
    echo ""
    echo -e "${AMARILLO}[*] Intentando adb root...${NC}"
    adb root
    sleep 2
    adb connect "$IP:5555"
    echo ""
    echo -e "${VERDE}[+] Dispositivo listo:${NC}"
    adb shell "id; su -c id"
    ;;

  magisk)
    BOOT="${2:-boot.img}"
    echo -e "${AMARILLO}[*] Parcheando boot.img con Magisk...${NC}"
    echo -e " 1. Copia $BOOT al teléfono:"
    echo -e "    adb push $BOOT /sdcard/"
    echo ""
    echo -e " 2. En el teléfono, abre Magisk → Instalar → Seleccionar archivo"
    echo -e "    Elige /sdcard/$BOOT → pulsa EMPEZAR"
    echo ""
    echo -e " 3. Vuelve el archivo parcheado al PC:"
    echo -e "    adb pull /sdcard/Download/magisk_patched-*.img"
    echo ""
    echo -e " 4. Flashea desde bootloader:"
    echo -e "    adb reboot bootloader"
    echo -e "    fastboot flash boot magisk_patched-*.img"
    echo -e "    fastboot reboot"
    ;;

  dump-boot)
    echo -e "${AMARILLO}[*] Extrayendo boot.img del dispositivo...${NC}"
    adb shell "su -c 'dd if=/dev/block/bootdevice/by-name/boot of=/sdcard/boot.img'"
    adb pull /sdcard/boot.img ./boot_stock.img
    echo -e "${VERDE}[+] boot.img extraído: ./boot_stock.img${NC}"
    md5sum ./boot_stock.img
    ;;

  vmware)
    cat << 'EOF'
=== Instalar Android x86 en VMware ===

1. Descargar ISO: https://sourceforge.net/projects/android-x86/files/Release%209.0/
   - android-x86_64-9.0-r2.iso

2. En VMware Workstation:
   - Nueva VM → Típico
   - Instalador del SO: android-x86_64-9.0-r2.iso
   - SO: "Other Linux 5.x 64-bit"
   - 4 GB RAM, 16 GB disco
   - Red: NAT o Bridge

3. Arrancar ISO, elegir "Install" (no "Live CD")
   - Crear partición: GPT → New → Write → Quit
   - Partición ext4 en /dev/sda1
   - Instalar GRUB: Sí
   - Instalar /system como read-write: Sí

4. Dentro del SO ya instalado:
   - Arrancar, ir a Settings → Developer options → USB debugging ON
   - Obtener IP: Settings → About → Status → IP address
   - Verificar conectividad en Parrot:
     adb connect <ip>:5555
     adb root
EOF
    ;;

  info)
    echo "Uso: android-device-setup.sh <comando>"
    echo ""
    echo "Comandos:"
    echo "  usb              Conectar y rootear dispositivo por USB"
    echo "  tcp <ip>         Conectar y rootear por red (adb connect)"
    echo "  magisk [boot]    Guía para rootear con Magisk"
    echo "  dump-boot        Extraer boot.img del dispositivo"
    echo "  vmware           Guía para instalar Android x86 en VMware"
    ;;
esac
