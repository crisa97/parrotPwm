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
- El fondo de pantalla se toma de `~/Wallpapers/wallpaper.*`

> **Nota:** Si usas Parrot OS 6.x, utiliza `parrotpwm.sh` (versión original).
> `parrotpwm-v2.sh` está adaptado para Parrot OS 7.x.

## Atajos de teclado

### Terminal / Lanzadores

| Atajo | Descripción |
|-------|-------------|
| `Win + Enter` | Terminal (Kitty) |
| `Win + '` | Terminal flotante (dropdown) |
| `Win + D` | Lanzador de apps (Rofi) |
| `Win + Shift + D` | Lanzador de comandos (Rofi) |
| `Win + A` | Cambiar ventana (Rofi) |

### BSPWM / Ventanas

| Atajo | Descripción |
|-------|-------------|
| `Win + W` | Cerrar ventana |
| `Win + Shift + W` | Forzar cierre (kill) |
| `Win + S` | Modo flotante |
| `Win + T` | Modo tiled |
| `Win + Shift + T` | Modo pseudo-tiled |
| `Win + F` | Fullscreen |
| `Win + M` | Alternar layout (tiled/monocle) |
| `Win + G` | Swap con ventana más grande |
| `Escape` | Salir de fullscreen |
| `Win + Y` | Enviar nodo marcado al preseleccionado |

### Navegación

| Atajo | Descripción |
|-------|-------------|
| `Win + Flechas` | Focus en dirección |
| `Win + Shift + Flechas` | Mover ventana en dirección |
| `Win + 1-0` | Ir al escritorio 1-10 |
| `Win + Shift + 1-0` | Mover ventana a escritorio |
| `Win + Tab` | Último escritorio / nodo |
| `Win + \`` | Último nodo |
| `Win + [` / `]` | Escritorio anterior / siguiente |
| `Win + P` | Focus al nodo padre |
| `Win + ,` | Focus al primer nodo |
| `Win + .` | Focus al segundo nodo |
| `Win + C` | Siguiente ventana visible |
| `Win + Shift + C` | Ventana anterior visible |
| `Win + O` | Nodo anterior en historial |
| `Win + I` | Nodo más reciente en historial |
| `Alt + Tab` | Siguiente ventana |
| `Alt + Shift + Tab` | Ventana anterior |

### Redimensionar / Mover flotantes

| Atajo | Descripción |
|-------|-------------|
| `Win + Alt + Flechas` | Redimensionar ventana |
| `Win + Ctrl + Flechas` | Mover ventana flotante |
| `Win + Ctrl + 1-9` | Ratio de preselección |
| `Win + Ctrl + Space` | Cancelar preselección |
| `Win + Ctrl + Alt + Space` | Cancelar todas las preselecciones |
| `Win + Ctrl + Alt + Flechas` | Preseleccionar dirección |

### Marcadores / Flags

| Atajo | Descripción |
|-------|-------------|
| `Win + Ctrl + M` | Marcar nodo |
| `Win + Ctrl + X` | Bloquear nodo (locked) |
| `Win + Ctrl + Y` | Sticky |
| `Win + Ctrl + Z` | Private |

### Sistema

| Atajo | Descripción |
|-------|-------------|
| `Win + Alt + R` | Recargar bspwm |
| `Win + Alt + Q` | Salir de bspwm |
| `Ctrl + Win + L` | Bloquear pantalla (i3lock-color + dim) |
| `Win + Escape` | Recargar sxhkd |

### Aplicaciones

| Atajo | Descripción |
|-------|-------------|
| `Win + B` | Burp Suite |
| `Win + E` | Dolphin (gestor de archivos) |
| `Win + V` | VSCodium |
| `Win + Shift + F` | Firefox |
| `Ctrl + Win + O` | Obsidian |
| `Win + Ctrl + P` | gpick (selector de color) |
| `Alt + P` | Postman |

### Capturas de pantalla

| Atajo | Descripción |
|-------|-------------|
| `Print` | Seleccionar área |
| `Ctrl + Print` | Pantalla completa |
| `Alt + Print` | Ventana activa |

### Volumen

| Atajo | Descripción |
|-------|-------------|
| `Win + F2` | Bajar volumen |
| `Win + F3` | Subir volumen |
| `Win + F4` | Silenciar / activar |
| `XF86AudioRaiseVolume` | Subir volumen (teclas multimedia) |
| `XF86AudioLowerVolume` | Bajar volumen (teclas multimedia) |
| `XF86AudioMute` | Silenciar (teclas multimedia) |

### Brillo

| Atajo | Descripción |
|-------|-------------|
| `XF86MonBrightnessUp` | Subir brillo |
| `XF86MonBrightnessDown` | Bajar brillo |
| `XF86KbdBrightnessUp` | Subir brillo teclado |
| `XF86KbdBrightnessDown` | Bajar brillo teclado |

### Portapapeles

| Atajo | Descripción |
|-------|-------------|
| `Ctrl + Alt + C` | Copiar selección al portapapeles |
| `Ctrl + Alt + V` | Pegar desde el portapapeles |

### Kitty (terminal)

| Atajo | Descripción |
|-------|-------------|
| `Ctrl + Shift + Enter` | Nueva ventana (split) |
| `Ctrl + Shift + T` | Nuevo tab |
| `Ctrl + Shift + Flechas` | Navegar entre ventanas |
| `Ctrl + Shift + ]` | Siguiente tab |
| `Ctrl + Shift + [` | Tab anterior |
| `Ctrl + Shift + Z` | Layout stack |
| `Ctrl + Shift + A` | Renombrar tab |
| `Ctrl + Left` / `Right` | Saltar palabra |
| `Alt + Left` / `Right` | Inicio / final de línea |

### Polybar

| Acción | Descripción |
|--------|-------------|
| Clic izquierdo (lanzador) | Rofi (apps) |
| Clic izquierdo (fecha) | Calendario |
| Clic izquierdo (sysmenu) | Menú de apagado |
| Clic derecho (lanzador) | Cambiar tema |
| Scroll (workspaces) | Cambiar escritorio |

### Otros comandos

| Comando | Descripción |
|---------|-------------|
| `target <IP>` | Seleccionar objetivo (se muestra en polybar) |
| `target reset` | Eliminar objetivo |
| `screenshot` | Captura de pantalla (flameshot) |
| `tmux` | Cambiar a tmux |
| `p10k configure` | Configurar Powerlevel10K |
| `bpython` | Python interactivo |

## Paquetes incluidos

```
Bspwm              Polybar            Oh my zsh + Plugins
Powerlevel10k      Hack Nerd Fonts    JetBrains Font
Python + pip       bpython            Tmux + Oh my tmux
Kitty              lsd                Batcat
Fastfetch          flameshot          feh
Rofi               Sxhkd              Picom
Neovim             dirsearch          feroxbuster
Dolphin (KDE)      Kate (KDE)         Obsidian
gpick              Dunst              CopyQ
brightnessctl      playerctl          yad
xdotool            xclip              i3lock-color
Conky              Redshift           nm-applet
```

## Créditos

- Autor original: crisa97 (parrotpwm)
- YouTube: https://youtube.com/@crisa97
- Instagram: https://www.instagram.com/crisa97
- Adaptado para Parrot OS por: tu-usuario
