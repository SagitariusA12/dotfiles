--############
--## INPUT ###
--############
-- See https://wiki.hypr.land/Configuring/Variables/#input


hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.device({
    name = "usb-gaming-mouse-1",
    sensitivity = 0,
})

hl.device({
    name = "ugtablet-6-inch-pentablet-pen",
    output = "eDP-1",
    --    output          = HDMI-A-1
    --    region_position = 0, 0
    --    region_size     = 111, 70
})

hl.config({
    input = {
        kb_layout = "us,br",
        kb_variant = ",abnt2",
        kb_model = "",
        kb_options = "grp:alt_shift_toggle",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0, -- -1.0 - 1.0, 0 = no modification
        touchpad = {
            natural_scroll = true,
        },
    },
    -- See https://wiki.hypr.land/Configuring/Gestures
    -- Per-device config
    -- See https://wiki.hypr.land/Configuring/Keywords/#per-device-input-configs
})

