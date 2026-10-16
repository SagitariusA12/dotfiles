--################
--## AUTOSTART ###
--################

-- exec-once = waybar
-- exec-once = awww-daemon
-- exec-once = awww img ~/wallpapers/Wallpaper-Bank/wallpapers/Dynamic-Wallpapers/Light/Forest-Light.png

-- exec-once = kwalletd6

hl.on("hyprland.start", function()
	hl.exec_cmd("kbuildsycoca6")
	-- hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
	-- hl.exec_cmd("wl-paste --type text  --watch cliphist store")
	-- hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("dunst")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("nm-applet --indicator")
	-- hl.exec_cmd(
	-- 	[[sh -c 'socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read l; do echo "$(date +%T.%N) $l"; done > /tmp/hypr-events.log']]
	-- )
	hl.exec_cmd("ambxst")
	--     hl.exec_cmd("sleep 3 && hyprctl dispatch dpms off && sleep 1 && hyprctl dispatch dpms on")
end)
