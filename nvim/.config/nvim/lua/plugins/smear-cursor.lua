return {
    "sphamba/smear-cursor.nvim",

    opts = {
        smear_between_buffers = true,
        smear_between_neighbor_lines = true,
        scroll_buffer_space = true,
        legacy_computing_symbols_support = false,
        smear_insert_mode = true,

        -- Equivalente a cursor_trail 3 (rastro curto e sutil)
        stiffness = 0.8,       -- mais rígido = rastro mais curto
        trailing_stiffness = 0.5, -- cauda mais curta, some rápido
        trailing_exponent = 2, -- cauda afunilada (mais parecida com um "trail" curto)
        distance_stop_animating = 1, -- para de animar mais cedo

        -- Equivalente a cursor_trail_start_threshold 2
        min_horizontal_distance_smear = 2,
        min_vertical_distance_smear = 2,
    },
}
