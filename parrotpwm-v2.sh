#!/bin/bash

# Colores
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

# Comprobar si el usuario actual es root
if [ "$UID" -eq 0 ]; then
    echo -e "${RED}[-] No se puede ejecutar como root.${RESET}"
    exit 1
else
    if [ -n "$SUDO_USER" ]; then
        echo -e "${RED}[-] No uses sudo.${RESET}"
        exit 1
    fi
fi

# Pedir contraseña sudo al inicio para usarla durante todo el script
echo -e "${BLUE}[*] Este script necesita permisos sudo.${RESET}"
read -r -s -p "[?] Contraseña sudo: " SUDO_PASS
echo ""

# Validar contraseña sudo
echo "$SUDO_PASS" | sudo -S -v 2>/dev/null
if [ $? -ne 0 ]; then
    echo -e "${RED}[-] Contraseña sudo incorrecta.${RESET}"
    exit 1
fi

# Función para ejecutar comandos con sudo sin necesidad de terminal
exec_sudo() {
    echo "$SUDO_PASS" | sudo -S "$@"
}

# Función para refrescar el timestamp de sudo
keep_sudo() {
    while true; do
        echo "$SUDO_PASS" | sudo -S -v >/dev/null 2>&1
        sleep 60
    done
}

# Iniciar refresco de sudo en segundo plano
keep_sudo &
KEEP_SUDO_PID=$!

echo -e "${GREEN}
██████╗  █████╗ ██████╗ ██████╗  ██████╗ ████████╗██████╗ ██╗    ██╗███╗   ███╗
██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔═══╝ ╚══██╔══╝██╔══██╗██║    ██║████╗ ████║
██████╔╝███████║██████╔╝██████╔╝██║        ██║   ██████╔╝██║ █╗ ██║██╔████╔██║
██╔═══╝ ██╔══██║██╔══██╗██╔══██╗██║        ██║   ██╔══██╗██║███╗██║██║╚██╔╝██║
██║     ██║  ██║██║  ██║██║  ██║╚██████╗   ██║   ██║  ██║╚███╔███╔╝██║ ╚═╝ ██║
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝     ╚═╝
"

sleep 2
echo -e "[+] Script de automatización de entorno de hacking profesional.${RESET}"
sleep 1
echo -e "[+] Adaptado de afsh4ck/parrotpwm para Parrot OS 7.x"
sleep 3
echo -e "\n${BLUE}[*] Configurando la instalación..${RESET}\n"
sleep 3

RPATH=`pwd`

# Actualizar paquetes
echo -e "\n${BLUE}[*] Actualizando paquetes..${RESET}\n"
exec_sudo apt update

# Instalar paquetes
echo -e "\n${BLUE}[*] Instalando paquetes..${RESET}\n"
exec_sudo apt install -y git bspwm vim feh scrot scrub zsh rofi xclip xsel locate wmname acpi sxhkd \
    imagemagick ranger kitty tmux python3-pip font-manager lsd bat bpython open-vm-tools fastfetch \
    dolphin kate

# dirsearch y feroxbuster (no todos están en repos de Parrot)
echo -e "\n${BLUE}[*] Instalando dirsearch..${RESET}\n"
exec_sudo apt install -y dirsearch 2>/dev/null || pipx install dirsearch 2>/dev/null || echo -e "${RED}[-] dirsearch no instalado${RESET}"

echo -e "\n${BLUE}[*] Instalando feroxbuster..${RESET}\n"
cd /tmp && curl -sL https://raw.githubusercontent.com/epi052/feroxbuster/main/install-nix.sh | bash && exec_sudo mv /tmp/feroxbuster /usr/bin/feroxbuster 2>/dev/null || {
    curl -sL https://github.com/epi052/feroxbuster/releases/latest/download/x86_64-linux-feroxbuster.zip -o /tmp/feroxbuster.zip
    unzip -q /tmp/feroxbuster.zip -d /tmp/feroxbuster_extract
    exec_sudo mv /tmp/feroxbuster_extract/feroxbuster /usr/bin/feroxbuster
    rm -rf /tmp/feroxbuster.zip /tmp/feroxbuster_extract
}
cd $RPATH

# Verificar lsd, bat, fastfetch
echo -e "\n${BLUE}[*] Verificando paquetes adicionales..${RESET}\n"
if ! command -v lsd &> /dev/null; then
    echo -e "${BLUE}[*] Instalando lsd desde GitHub..${RESET}"
    LFD_URL=$(curl -s https://api.github.com/repos/lsd-rs/lsd/releases/latest | grep "browser_download_url.*amd64.deb" | cut -d '"' -f 4)
    wget -q --show-progress "$LFD_URL" -O /tmp/lsd.deb
    exec_sudo dpkg -i /tmp/lsd.deb 2>/dev/null || exec_sudo apt install -f -y
    rm -f /tmp/lsd.deb
fi

if ! command -v batcat &> /dev/null && ! command -v bat &> /dev/null; then
    echo -e "${BLUE}[*] Instalando bat desde GitHub..${RESET}"
    BAT_URL=$(curl -s https://api.github.com/repos/sharkdp/bat/releases/latest | grep "browser_download_url.*amd64.deb" | cut -d '"' -f 4)
    wget -q --show-progress "$BAT_URL" -O /tmp/bat.deb
    exec_sudo dpkg -i /tmp/bat.deb 2>/dev/null || exec_sudo apt install -f -y
    rm -f /tmp/bat.deb
fi

if ! command -v fastfetch &> /dev/null; then
    echo -e "${BLUE}[*] Instalando fastfetch desde GitHub..${RESET}"
    FF_URL=$(curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest | grep "browser_download_url.*linux.amd64.deb" | cut -d '"' -f 4)
    if [ -n "$FF_URL" ]; then
        wget -q --show-progress "$FF_URL" -O /tmp/fastfetch.deb
        exec_sudo dpkg -i /tmp/fastfetch.deb 2>/dev/null || exec_sudo apt install -f -y
        rm -f /tmp/fastfetch.deb
    else
        echo -e "${RED}[-] No se pudo instalar fastfetch, puedes hacerlo manualmente.${RESET}"
    fi
fi

# Instalar dependencias del entorno
echo -e "\n${BLUE}[*] Instalando dependencias del entorno..${RESET}\n"
exec_sudo apt install -y build-essential libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev \
    libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev

# Instalar requisitos de polybar
echo -e "\n${BLUE}[*] Instalando requisitos de polybar..${RESET}\n"
exec_sudo apt install -y cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev \
    libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev \
    libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev \
    libmpdclient-dev libuv1-dev libnl-genl-3-dev

# Instalar dependencias de picom
echo -e "\n${BLUE}[*] Instalando dependencias de picom..${RESET}\n"
exec_sudo apt install -y meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev \
    libxcb-render-util0-dev libxcb-render0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev \
    libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev \
    uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev libpcre3 libpcre3-dev

# Instalar Hack Nerd Font
echo -e "\n${BLUE}[*] Instalando fuentes..${RESET}\n"
mkdir -p /tmp/fonts
wget -q --show-progress https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip -O /tmp/fonts/Hack.zip
unzip -q /tmp/fonts/Hack.zip -d /tmp/fonts
mkdir -p ~/.local/share/fonts
mv /tmp/fonts/*.ttf ~/.local/share/fonts/
rm -rf /tmp/fonts
fc-cache -fv

# Instalar JetBrains Mono Nerd Font
mkdir -p /tmp/fonts
wget -q --show-progress https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip -O /tmp/fonts/JetBrainsMono.zip
unzip -q /tmp/fonts/JetBrainsMono.zip -d /tmp/fonts
mv /tmp/fonts/*.ttf ~/.local/share/fonts/
rm -rf /tmp/fonts
fc-cache -fv

# Instalar powerlevel10k
echo -e "\n${BLUE}[*] Instalando tema powerlevel10k..${RESET}\n"
rm -rf ~/powerlevel10k
git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
rm -f ~/.p10k.zsh
cp -v $RPATH/CONFIGS/p10k.zsh ~/.p10k.zsh

# Instalar plugins de zsh
echo -e "\n${BLUE}[*] Instalando plugins de ZSH..${RESET}\n"
exec_sudo apt install -y zsh-autosuggestions zsh-autocomplete zsh-syntax-highlighting
rm -f ~/.zshrc
cp -v $RPATH/CONFIGS/zshrc ~/.zshrc

# Instalar fzf
echo -e "\n${BLUE}[*] Instalando fzf..${RESET}\n"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
yes | ~/.fzf/install

# .tmux
echo -e "\n${BLUE}[*] Instalando tmux..${RESET}\n"
rm -rf ~/.tmux
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -s -f ~/.tmux/.tmux.conf ~/
cp -v $RPATH/CONFIGS/tmux.conf.local ~/.tmux.conf.local

# nvim
echo -e "\n${BLUE}[*] Instalando nvim..${RESET}\n"
wget -q --show-progress https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz -O /tmp/nvim-linux64.tar.gz
exec_sudo tar xzvf /tmp/nvim-linux64.tar.gz --directory=/opt
exec_sudo ln -s /opt/nvim-linux64/bin/nvim /usr/bin/nvim
exec_sudo rm -f /opt/nvim-linux64.tar.gz

# Instalar terminal kitty
echo -e "\n${BLUE}[*] Instalando terminal kitty..${RESET}\n"
cat $RPATH/kitty-installer.sh | sh /dev/stdin

# Clonar repositorios de polybar & picom
mkdir ~/github
git clone --recursive https://github.com/polybar/polybar ~/github/polybar
git clone https://github.com/ibhagwan/picom.git ~/github/picom

# Instalar polybar
echo -e "\n${BLUE}[*] Instalando polybar..${RESET}\n"
cd ~/github/polybar
mkdir build
cd build
cmake ..
make -j$(nproc)
exec_sudo make install

# Instalar temas de polybar
echo -e "\n${BLUE}[*] Instalando temas de polybar..${RESET}\n"
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git ~/github/polybar-themes
chmod +x ~/github/polybar-themes/setup.sh
cd ~/github/polybar-themes
echo 1 | ./setup.sh

# Instalar picom
echo -e "\n${BLUE}[*] Instalando picom..${RESET}\n"
cd ~/github/picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
exec_sudo ninja -C build install

# Crear archivo de sesión para el gestor de pantalla (SDDM/LightDM)
echo -e "\n${BLUE}[*] Creando entrada de sesión para bspwm..${RESET}\n"
echo "$SUDO_PASS" | sudo -S tee /usr/share/xsessions/bspwm.desktop > /dev/null << 'EOF'
[Desktop Entry]
Name=bspwm
Comment=Binary window manager
Exec=bspwm
Type=Application
EOF

# Detectar zona horaria automáticamente
echo -e "\n${BLUE}[*] Detectando zona horaria..${RESET}\n"
TIMEZONE=$(curl -s ipinfo.io/timezone 2>/dev/null || echo "America/Bogota")
exec_sudo timedatectl set-timezone "$TIMEZONE"
echo -e "[+] Zona horaria configurada: $TIMEZONE"

mkdir ~/screenshots

# Copiar configuraciones
echo -e "\n${BLUE}[*] Instalando configuraciones..${RESET}\n"
cp -rv $RPATH/CONFIGS/config/* ~/.config/
cp -rv $RPATH/SCRIPTS/* ~/.config/polybar/forest/scripts/

# Detectar VM y activar resolución adecuada en bspwmrc
echo -e "\n${BLUE}[*] Detectando entorno de virtualización..${RESET}\n"
if systemd-detect-virt -q vmware 2>/dev/null; then
    echo -e "[+] VMware detectado, activando resolución 1920x1080"
    sed -i 's/# xrandr --output Virtual1/xrandr --output Virtual1/' ~/.config/bspwm/bspwmrc
elif systemd-detect-virt -q oracle 2>/dev/null; then
    echo -e "[+] VirtualBox detectado, activando resolución 1920x1080"
    VB_OUTPUT=$(xrandr 2>/dev/null | grep ' connected' | grep -i 'virtual\|vbox' | head -1 | cut -d' ' -f1)
    if [ -n "$VB_OUTPUT" ]; then
        sed -i "s/# xrandr --output Virtualbox-0/xrandr --output $VB_OUTPUT/" ~/.config/bspwm/bspwmrc
    else
        sed -i 's/# xrandr --output Virtualbox-0/xrandr --output VirtualBox/' ~/.config/bspwm/bspwmrc
    fi
else
    echo -e "[+] No se detectó VM o no es necesario configurar resolución automática"
fi
exec_sudo ln -s ~/.config/polybar/forest/scripts/target.sh /usr/bin/target
exec_sudo ln -s ~/.config/polybar/forest/scripts/screenshot.sh /usr/bin/screenshot

mkdir ~/Wallpapers/
cp -rv $RPATH/WALLPAPERS/* ~/Wallpapers/

# Reemplazar rutas hardcodeadas /home/crisa por $HOME
echo -e "\n${BLUE}[*] Ajustando rutas de usuario en configuraciones..${RESET}\n"
sed -i "s|/home/crisa|$HOME|g" ~/.zshrc
sed -i "s|/home/crisa|$HOME|g" ~/.config/sxhkd/sxhkdrc
sed -i "s|/home/crisa|$HOME|g" ~/.config/burpSuiteRun.sh 2>/dev/null || true

chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/scripts/bspwm_resize
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/forest/scripts/target.sh
chmod +x ~/.config/polybar/forest/scripts/screenshot.sh

# Detener el refresco de sudo
kill $KEEP_SUDO_PID 2>/dev/null

# Mensajes finales
echo -e "\n${BLUE}[+] Entorno ParrotPWM v2 desplegado, Happy Hacking ;)${RESET}\n"
echo -e "${BLUE}[+] Por favor, reinicia el equipo (sudo reboot)${RESET}\n"
echo -e "${BLUE}[+] En la pantalla de login, selecciona 'bspwm' como sesión${RESET}\n"
