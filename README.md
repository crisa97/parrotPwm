# ParrotPWM

Despliega un entorno de hacking profesional para Parrot OS ejecutando solo un script.

Adaptado de [crisa97/parrotpwm](https://github.com/crisa97/parrotpwm) para Parrot OS.

## Instalación y uso

- Se recomienda el uso de una instalación nueva/limpia de Parrot OS.
- Testado en Parrot OS 6.x con VMware, VirtualBox y Bare Metal.

```
git clone https://github.com/tu-usuario/parrotpwm.git
cd parrotpwm
bash parrotpwm.sh
sudo reboot
```
- Una vez reiniciado, selecciona **bspwm** en la pantalla de inicio de sesión (LightDM).
- El fondo de pantalla se toma de ~/Wallpapers/wallpaper.*

## Comandos

| Comando                     | Descripción                                                 |
|-----------------------------|-------------------------------------------------------------|
| Clic derecho en Polybar     | Cambia el tema de Polybar usando el menú del clic derecho   |
| Windows + 1,2,3,4           | Navega entre escritorios                                    |
| Windows + Enter             | Abre una nueva terminal                                     |
| Windows + Flechas           | Navega entre ventanas abiertas                              |
| Windows + Tab               | Cambia entre los dos escritorios más recientes              |
| Windows + Shift + W         | Cierra la terminal actual                                   |
| Windows + Alt + R           | Recarga el entorno de escritorio                            |
| Windows + Alt + Q           | Reiniciar BSPWM                                             |
| Windows + Alt + Flechas     | Redimensiona la ventana actual                              |
| Windows + Shift + F         | Abre Firefox                                                |
| Windows + Shift + B         | Abre Burp Suite                                             |
| Windows + Shift + A         | Abre el gestor de archivos Thunar                           |
| Windows + Shift + 1,2,3,4   | Mueve la ventana actual a otro escritorio                   |
| Windows + Shift + Flechas   | Mueve la ventana actual                                     |
| Ctrl + Shift + -+           | Cambia el tamaño del texto en la terminal                   |
| Ctrl + T                    | Abre un buscador avanzado desde la terminal                 |
| .config/sxhkd/sxhkdrc       | Archivo de configuración de atajos (sxhkd)                  |
| .config/bspwm/bspwmrc       | Archivo de configuración de BSPWM                           |
| .config/polybar             | Carpeta con temas de Polybar                                |
| .config/kitty/kitty.conf    | Archivo de configuración predeterminado para el terminal Kitty |
| ~/Wallpapers                | Carpeta de fondos de pantalla. Solo se permite un archivo llamado wallpaper.jpg |
| target 10.0.0.1             | Selecciona una IP de destino y se muestra en la Polybar     |
| target reset                | Elimina el objetivo seleccionado                            |
| tmux                        | Cambia la terminal a tmux                                   |
| tmux --help                 | Muestra la ayuda de tmux                                    |
| p10k configure              | Configura el tema de terminal Powerlevel10K                 |
| .zshrc                      | Archivo de configuración de ZSH y alias de comandos         |
| bpython                     | Python interactivo en la terminal                           |

## Paquetes incluídos:

```
Bspwm
Polybar
Oh my zsh + Plugins
Powerlevel10k
Hack Nerd Fonts
JetBrains Font
Python + pip + bpython
Tmux + Oh my tmux
Kitty
lsd
Batcat
Fastfetch
Scrot
feh
Rofi
Sxhkd
Picom
Neovim
dirsearch
feroxbuster
```

## Créditos

- Autor original: crisa97 (parrotpwm)
- YouTube: https://youtube.com/@crisa97
- Instagram: https://www.instagram.com/crisa97
- Adaptado para Parrot OS por: tu-usuario
