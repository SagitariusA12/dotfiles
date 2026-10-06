-- #######################################################################################
-- HYPRLAND CONFIG - MODULAR
-- https://wiki.hypr.land/Configuring/
-- #######################################################################################

-- Ambxst
-- source = ~/.local/share/ambxst/hyprland.conf

-- Resolução, refresh rate e posição de cada monitor

require("conf_d.monitors")

-- Variáveis dos programas padrão: terminal, browser, file manager e launcher
require("conf_d.programs")

-- Processos iniciados automaticamente com o Hyprland (waybar, swww, clipboard, etc.)
require("conf_d.autostart")

-- Variáveis de ambiente: cursor, XDG, toolkits (GTK/Qt), NVIDIA
require("conf_d.env")

-- Visual: gaps, bordas, cores, sombra, blur, animações e layout
require("conf_d.look_and_feel")

-- Teclado, mouse, touchpad, sensibilidade e gestos
require("conf_d.input")

-- Todos os atalhos de teclado e mouse
require("conf_d.keybinds")

-- Regras de comportamento por janela (float, foco, posição, supressão de eventos)
require("conf_d.windowrules")

-- Ax-Shell
-- source = ~/.config/Ax-Shell/config/hypr/ax-shell.conf

-- OVERRIDES
-- Down here you can write or source anything that you want to override from Ambxst's settings.
