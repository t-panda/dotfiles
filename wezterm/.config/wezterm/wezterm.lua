local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
    automatically_reload_config = true,
    enable_tab_bar = false,
    window_close_confirmation = "NeverPrompt",
    window_decorations = "RESIZE",
    default_cursor_style = "SteadyBar",
    color_scheme = 'Catppuccin Mocha',
    font = wezterm.font("JetBrains Mono", {
        weight = "Bold"
    }),
    font_size = 16,
    initial_rows = 40,
    initial_cols = 125,
    
    default_prog = {"/bin/zsh", "-i"},
    window_padding = {
        left = 8,
        right = 8,
        top = 8,
        bottom = 3
    }
}

return config
