-- pull in the wezterm api
local wezterm = require 'wezterm'
-- This table will hold the configuration.
local config = {}
local act = wezterm.action
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- ============================
-- SHELL SETTINGS
-- ============================
-- Gunakan full path agar tidak gagal deteksi
config.default_prog = { '/bin/zsh', '-l' }
config.window_close_confirmation = 'NeverPrompt'
--config.window_close_confirmation = 'AlwaysPrompt'

--[[
============================
-- Performance settings
============================
]] --

config.max_fps = 120
config.animation_fps = 240
config.window_background_opacity = 0.98
config.enable_scroll_bar = false

config.term = "xterm-256color"
config.warn_about_missing_glyphs = false
-- Auto-detect Wayland based on environment
local is_wayland = os.getenv("WAYLAND_DISPLAY") ~= nil or
                   os.getenv("XDG_SESSION_TYPE") == "wayland"
config.enable_wayland = is_wayland
config.front_end = "OpenGL"
config.webgpu_power_preference = "HighPerformance"
config.prefer_egl = true
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"


-- change to square if you don't like rounded tab style
local tab_style = "square"

config.window_decorations = "RESIZE"
-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28
config.scrollback_lines = 5000 -- default biasanya 3500
--[[
============================
-- Colors
============================
]] --
-- config.color_scheme = 'Tokyo Night Moon'

local color_scheme = "Catppuccin Macchiato"
config.color_scheme = color_scheme

-- color_scheme not sufficient in providing available colors
-- local colors = wezterm.color.get_builtin_schemes()[color_scheme]

-- color scheme colors for easy access
local scheme_colors = {
    catppuccin = {
        macchiato = {
            rosewater = "#f4dbd6",
            flamingo = "#f0c6c6",
            pink = "#f5bde6",
            mauve = "#c6a0f6",
            red = "#ed8796",
            maroon = "#ee99a0",
            peach = "#f5a97f",
            yellow = "#eed49f",
            green = "#a6da95",
            teal = "#8bd5ca",
            sky = "#91d7e3",
            sapphire = "#7dc4e4",
            blue = "#8aadf4",
            lavender = "#b7bdf8",
            text = "#cad3f5",
            crust = "#181926",
            iceblue = "#0d1117",
            black = "#000000",
            white = "#dedede"
        }
    }
}

local colors = {
    border = scheme_colors.catppuccin.macchiato.crust,
    tab_bar_active_tab_fg = scheme_colors.catppuccin.macchiato.mauve,
    tab_bar_active_tab_bg = scheme_colors.catppuccin.macchiato.crust,
    tab_bar_text = scheme_colors.catppuccin.macchiato.crust,
    arrow_foreground_leader = scheme_colors.catppuccin.macchiato.lavender,
    arrow_background_leader = scheme_colors.catppuccin.macchiato.crust,
}


--[[
============================
-- FONTS
============================
]] --
 
-- Font configuration
config.font = wezterm.font_with_fallback({
  {family='JetBrainsMono Nerd Font', weight='Regular'},  
  {family='Iosevka Nerd Font', weight='Regular'},
  {family='MesloLGL Nerd Font', weight='Regular'},
  {family='DejaVuSansM Nerd Font Mono', weight='Regular'}
})
config.font_size = 14
config.line_height = 0.9
config.cell_width = 0.95

--[[
============================
-- TABS
============================
]] --

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
--config.use_fancy_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

--[[
============================
-- WINDOW
============================
]] --

config.window_padding = {
	left = 0,
	right = 0,
	top = 2,
	bottom = 0,
}

config.window_frame = {
	border_left_width = "0.5cell",
	border_right_width = "0.5cell",
	border_bottom_height = "0.18cell",
	border_top_height = "0.18cell",
	border_left_color = colors.border,
	border_right_color = colors.border,
	border_bottom_color = colors.border,
	border_top_color = colors.border,

  -- The font used in the tab bar.
  -- Roboto Bold is the default; this font is bundled
  -- with wezterm.
  -- Whatever font is selected here, it will have the
  -- main font setting appended to it to pick up any
  -- fallback fonts you may have used there.
  font = wezterm.font { family = 'Roboto', weight = 'Bold' },

  -- The size of the font in the tab bar.
  -- Default to 10.0 on Windows but 12.0 on other systems
  font_size = 12.0,

  -- The overall background color of the tab bar when
  -- the window is focused
  active_titlebar_bg = '#333333',

  -- The overall background color of the tab bar when
  -- the window is not focused
  inactive_titlebar_bg = '#333333',
}

config.colors = {
  tab_bar = {
    -- The color of the inactive tab bar edge/divider
    inactive_tab_edge = '#575757',
  },
}


--[[
============================
-- KEYBINDS
============================
]] --
config.keys = {}
-- Pane management
for _, v in ipairs({
  {"Enter", act.SplitHorizontal{domain='CurrentPaneDomain'}},
  {"w", act.CloseCurrentPane{confirm=false}},
  {"LeftArrow", act.ActivatePaneDirection'Left'},
  {"RightArrow", act.ActivatePaneDirection'Right'},
  {"UpArrow", act.ActivatePaneDirection'Up'},
  {"DownArrow", act.ActivatePaneDirection'Down'},
  {"t", act.SpawnTab'CurrentPaneDomain'},
  {"q", act.CloseCurrentTab{confirm=false}},
  {"c", act.CopyTo'ClipboardAndPrimarySelection'},
  {"v", act.PasteFrom'Clipboard'},
  {"=", act.IncreaseFontSize},
  {"-", act.DecreaseFontSize},
  {"0", act.ResetFontSize},
}) do table.insert(config.keys, {mods="ALT", key=v[1], action=v[2]}) end

-- ALT+SHIFT combinations
table.insert(config.keys, {mods="ALT|SHIFT", key="Enter", action=act.SplitVertical{domain='CurrentPaneDomain'}})

-- Tab navigation (ALT+1-8)
for i = 0, 7 do table.insert(config.keys, {mods="ALT", key=tostring(i+1), action=act.ActivateTab(i)}) end

-- Tab movement and last tab (CTRL+ALT)
for _, v in ipairs({
  {"UpArrow", act.ActivateLastTab}, {"DownArrow", act.ActivateLastTab},
  {"LeftArrow", act.MoveTabRelative(-1)}, {"RightArrow", act.MoveTabRelative(1)}
}) do table.insert(config.keys, {mods="CTRL|ALT", key=v[1], action=v[2]}) end
for i = 0, 7 do table.insert(config.keys, {mods="CTRL|ALT", key=tostring(i+1), action=act.MoveTab(i)}) end

-- ALT+Delete should send ESC followed by the Delete sequence
-- The escape sequence is \x1b\x1b[3~
table.insert(config.keys, {
    mods = "ALT",
    key = "Delete",
    action = act.SendString("\x1b\x1b[3~")
})

table.insert(config.keys, {
  key = 'Delete',
  -- Menghapus 'mods' agar tombol Delete standar langsung berfungsi
  action = act.SendKey{ key = 'Delete' }
})

table.insert(config.keys, {
  key = 'Delete',
  action = act.SendString("\x1b[3~")
})

table.insert(config.keys, {
  mods = 'CTRL|ALT',
  key = 'j',
  action = wezterm.action.ScrollByPage(1)
})

table.insert(config.keys, {
  mods = 'CTRL|ALT',
  key = 'k',
  action = wezterm.action.ScrollByPage(-1)
})

-- Scroll Baris (Opsional, sangat berguna)
table.insert(config.keys, {
  mods = 'CTRL|ALT',
  key = 'u',
  action = act.ScrollByLine(-3) -- Scroll ke atas 3 baris
})
table.insert(config.keys, {
  mods = 'CTRL|ALT',
  key = 'd',
  action = act.ScrollByLine(3)  -- Scroll ke bawah 3 baris
})

--[[
============================
-- Mouse bindings
============================
]] --

config.mouse_bindings = {
  {event={Down={streak=1, button="Right"}}, mods="NONE", action=act.CopyTo("Clipboard")},
  {event={Down={streak=1, button="Middle"}}, mods="NONE", action=act.SplitHorizontal{domain="CurrentPaneDomain"}},
  {event={Down={streak=1, button="Middle"}}, mods="SHIFT", action=act.CloseCurrentPane{confirm=false}}
}

--[[
============================
-- Leader Active Indicator
============================
]] --


-- Finally, return the configuration to wezterm:
return config
