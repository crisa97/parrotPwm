# ParrotPWM

Despliega un entorno de hacking profesional para Parrot OS ejecutando solo un script.

Adaptado de [crisa97/parrotpwm](https://github.com/crisa97/parrotpwm) para Parrot OS.

## Instalación y uso

- Se recomienda el uso de una instalación nueva/limpia de Parrot OS.
- Testado en Parrot OS 7.x con VMware, VirtualBox y Bare Metal.

```
git clone https://github.com/tu-usuario/parrotpwm.git
cd parrotpwm
bash parrotpwm-v2.sh
sudo reboot
```
- Una vez reiniciado, selecciona **bspwm** en la pantalla de inicio de sesión (SDDM/LightDM).
- El fondo de pantalla se toma de ~/Wallpapers/wallpaper.*

> **Nota:** Si usas Parrot OS 6.x, utiliza `parrotpwm.sh` (versión original).  
> `parrotpwm-v2.sh` está adaptado para Parrot OS 7.x.

## Atajos de teclado

### BSPWM / Ventanas

| Atajo | Descripción |
|-------|-------------|
| `Win + Enter` | Abre Kitty |
| `Win + D` | Lanzador de programas (Rofi) |
| `Win + W` | Cerrar ventana |
| `Win + Shift + W` | Forzar cierre |
| `Win + S` | Modo flotante |
| `Win + T` | Modo tiled |
| `Win + Shift + T` | Modo pseudo-tiled |
| `Win + F` | Fullscreen (abajo del polybar) |
| `Win + M` | Alternar layout (tiled/monocle) |
| `Win + G` | Swap con ventana más grande |

### Navegación

| Atajo | Descripción |
|-------|-------------|
| `Win + Flechas` | Focus en dirección |
| `Win + Shift + Flechas` | Mover ventana en dirección |
| `Win + 1-0` | Ir al escritorio 1-10 |
| `Win + Shift + 1-0` | Mover ventana a escritorio |
| `Win + Tab` | Último escritorio |
| `Win + Grave (\`\`)` | Último nodo |
| `Win + [, ]` | Escritorio anterior / siguiente |
| `Win + P` | Focus al nodo padre |
| `Win + ,` | Focus al primer nodo |
| `Win + .` | Focus al segundo nodo |
| `Win + C` | Siguiente ventana visible |
| `Win + Shift + C` | Ventana anterior visible |
| `Win + O` | Nodo anterior en historial |
| `Win + I` | Nodo más reciente en historial |

### Redimensionar / Mover flotantes

| Atajo | Descripción |
|-------|-------------|
| `Win + Alt + Flechas` | Redimensionar ventana |
| `Win + Ctrl + Flechas` | Mover ventana flotante |
| `Win + Ctrl + 1-9` | Ratio de preselección |
| `Win + Ctrl + Space` | Cancelar preselección |
| `Win + Ctrl + Alt + Flechas` | Preseleccionar dirección |

### Marcadores

| Atajo | Descripción |
|-------|-------------|
| `Win + Ctrl + M` | Marcar nodo |
| `Win + Ctrl + X` | Bloquear nodo |
| `Win + Ctrl + Y` | Sticky |
| `Win + Ctrl + Z` | Private |

### Aplicaciones

| Atajo | Descripción |
|-------|-------------|
| `Win + B` | Burp Suite |
| `Win + E` | Gestor de archivos (Caja) |
| `Win + Shift + F` | Firefox |
| `Alt + P` | Postman |
| `Print` | Captura de pantalla (selección) |
| `Ctrl + Print` | Captura de pantalla completa |
| `Alt + Print` | Captura de ventana |

### Sistema

| Atajo | Descripción |
|-------|-------------|
| `Win + Alt + R` | Recargar bspwm |
| `Win + Alt + Q` | Salir de bspwm |
| `Win + Escape` | Recargar sxhkd |

### Volumen

| Atajo | Descripción |
|-------|-------------|
| `F2` | Bajar volumen |
| `F3` | Subir volumen |
| `F4` | Silenciar / activar |
| Teclas multimedia | Subir / bajar / silenciar |

### Kitty (terminal)

| Atajo | Descripción |
|-------|-------------|
| `Ctrl + Shift + Enter` | Nuevo split |
| `Ctrl + Shift + T` | Nuevo tab |
| `Ctrl + Shift + Flechas` | Navegar entre splits |
| `Ctrl + Shift + ]` | Siguiente tab |
| `Ctrl + Shift + [` | Tab anterior |
| `Ctrl + Shift + Z` | Modo stack |
| `Ctrl + Left` / `Right` | Saltar palabra |
| `Alt + Left` / `Right` | Inicio / final línea |

### Otros

| Comando | Descripción |
|---------|-------------|
| `target <IP>` | Seleccionar objetivo (se muestra en polybar) |
| `target reset` | Eliminar objetivo |
| `tmux` | Cambiar a tmux |
| `p10k configure` | Configurar Powerlevel10K |
| `bpython` | Python interactivo |
| Clic derecho en polybar | Cambiar tema

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
Dolphin (KDE)
Kate (KDE)
```

## Créditos

- Autor original: crisa97 (parrotpwm)
- YouTube: https://youtube.com/@crisa97
- Instagram: https://www.instagram.com/crisa97
- Adaptado para Parrot OS por: tu-usuario
