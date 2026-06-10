#!/bin/bash

VERSION=$(< /home/crisa/BurpSuitePro/version.txt)
# 1️⃣ Lanzar Burp Suite escondiendo la terminal
burpsuitepro > /dev/null 2>&1 & disown

#echo "[1] Iniciando Burp Suite... esperando primera ventana."

# ➤ Buscar PRIMERA ventana
FIRST_WIN=""
while [ -z "$FIRST_WIN" ]; do
    FIRST_WIN=$(wmctrl -l | grep "Burp Suite" | awk '{print $1}' | head -n 1)
    sleep 1
done

#echo "[1] Primera ventana detectada: $FIRST_WIN"

# ➤ Maximizar ventana
wmctrl -ir "$FIRST_WIN" -b add,maximized_vert,maximized_horz

# ➤ Cambiar nombre
xprop -id "$FIRST_WIN" -f _NET_WM_NAME 8u -set _NET_WM_NAME \
"Burp Suite Community V${VERSION} - Temporary Project"

#echo "[1] Nombre cambiado."

# 2️⃣ Esperar 30 segundos
sleep 15
#echo "[2] Buscando segunda ventana..."

# ➤ Buscar SEGUNDA ventana (DISTINTA del primer ID)
SECOND_WIN=""
while [ -z "$SECOND_WIN" ]; do
    SECOND_WIN=$(wmctrl -l | grep "Burp Suite" | awk '{print $1}' | grep -v "$FIRST_WIN" | head -n 1)
    sleep 1
done

#echo "[2] Segunda ventana detectada: $SECOND_WIN"

# ➤ Maximizar ventana
wmctrl -ir "$SECOND_WIN" -b add,maximized_vert,maximized_horz

# ➤ Cambiar nombre de la segunda ventana
xprop -id "$SECOND_WIN" -f _NET_WM_NAME 8u -set _NET_WM_NAME \
"Burp Suite Community V${VERSION} - Temporary Project"

#echo "[2] Nombre cambiado correctamente en el segundo proceso."
