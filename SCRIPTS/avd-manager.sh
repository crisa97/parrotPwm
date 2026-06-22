#!/bin/bash
# === Helper para crear y gestionar AVD (emulador Android) ===

ROJO='\033[0;31m'
VERDE='\033[0;32m'
AMARILLO='\033[1;33m'
NC='\033[0m'

export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/36.0.0:$PATH"

case "${1:-}" in
  create)
    NAME="${2:-PixelRoot}"
    echo -e "${AMARILLO}[*] Creando AVD: $NAME...${NC}"

    # Listar imágenes disponibles
    echo -e "[*] Imágenes disponibles:"
    $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --sdk_root=$ANDROID_HOME --list 2>/dev/null | grep "system-images;android-34;google_apis;x86_64"

    echo ""
    echo -e "[*] Descargando imagen (si no está)..."
    $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --sdk_root=$ANDROID_HOME "system-images;android-34;google_apis;x86_64"

    echo ""
    echo -e "[*] Creando AVD..."
    echo no | $ANDROID_HOME/cmdline-tools/latest/bin/avdmanager create avd \
      -n "$NAME" \
      -k "system-images;android-34;google_apis;x86_64" \
      -d pixel_6 \
      -f

    # Configurar software rendering (forzar sin GPU física)
    AVD_DIR="$HOME/.android/avd/${NAME}.avd"
    if [ -d "$AVD_DIR" ]; then
      echo "hw.gpu.enabled=yes" >> "$AVD_DIR/config.ini"
      echo "hw.gpu.mode=host" >> "$AVD_DIR/config.ini"
      echo "hw.ramSize=2048" >> "$AVD_DIR/config.ini"
      echo "disk.dataPartition.size=4096M" >> "$AVD_DIR/config.ini"
      echo "fastboot.forceColdBoot=yes" >> "$AVD_DIR/config.ini"
    fi

    echo -e "${VERDE}[+] AVD '$NAME' creado.${NC}"
    echo -e "[*] Para arrancar (LENTO sin KVM):"
    echo -e "    $ANDROID_HOME/emulator/emulator -avd $NAME -gpu swiftshader_indirect -no-boot-anim"
    echo -e "[*] Para arrancar con snapshots (más rápido tras primer arranque):"
    echo -e "    $ANDROID_HOME/emulator/emulator -avd $NAME -gpu swiftshader_indirect -snapshot"
    echo -e "[*] Para root: adb root (Google APIs lo soporta)"
    ;;

  start)
    NAME="${2:-PixelRoot}"
    echo -e "${AMARILLO}[*] Arrancando AVD: $NAME (modo software)...${NC}"
    echo -e "${ROJO}[!] Sin KVM será EXTREMADAMENTE lento. Usa un dispositivo físico.${NC}"
    $ANDROID_HOME/emulator/emulator -avd "$NAME" -gpu swiftshader_indirect -no-boot-anim -no-audio &
    echo -e "[*] Esperando dispositivo..."
    adb wait-for-device
    adb root
    echo -e "${VERDE}[+] AVD listo.${NC}"
    ;;

  list)
    echo -e "${AMARILLO}[*] AVDs disponibles:${NC}"
    $ANDROID_HOME/cmdline-tools/latest/bin/avdmanager list avd
    echo ""
    echo -e "${AMARILLO}[*] Dispositivos conectados:${NC}"
    adb devices
    ;;

  kill)
    echo -e "${AMARILLO}[*] Matando emuladores...${NC}"
    adb emu kill 2>/dev/null
    pkill -f emulator 2>/dev/null
    echo -e "${VERDE}[+] Hecho.${NC}"
    ;;

  *)
    echo "Uso: avd-manager.sh <comando> [nombre]"
    echo ""
    echo "Comandos:"
    echo "  create [name]    Crear AVD Pixel 6 con API 34 + root"
    echo "  start  [name]    Arrancar AVD (software rendering)"
    echo "  list             Listar AVDs y dispositivos"
    echo "  kill             Matar emuladores"
    ;;
esac
