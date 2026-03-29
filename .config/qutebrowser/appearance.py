# ============================================================================
# APPEARANCE & DARK MODE
# ============================================================================

import os

c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.policy.images = 'never'
c.colors.webpage.preferred_color_scheme = 'dark'

# Dark mode exceptions
config.set('colors.webpage.darkmode.enabled', False, 'file://*')
config.set('colors.webpage.darkmode.enabled', False, '*://*.twitch.tv/*')

# ============================================================================
# UI (TABS, STATUSBAR, SCROLL)
# ============================================================================

# Tabs
c.tabs.padding = {'top': 0, 'bottom': 0, 'left': 5, 'right': 5}
c.tabs.indicator.width = 0
c.tabs.position = 'top'
c.tabs.new_position.related = 'next'
c.tabs.new_position.unrelated = 'next'
c.tabs.show = 'multiple'
c.tabs.title.format = '{index}: {audio}{current_title}'
c.tabs.title.alignment = 'left'
c.tabs.tooltips = False
c.tabs.favicons.show = 'always'
c.tabs.background = True
c.tabs.mousewheel_switching = False
c.tabs.last_close = 'close'

# Scrolling
c.scrolling.smooth = False
c.scrolling.bar = 'never'

# Statusbar
c.statusbar.padding = {"top": 0, "bottom": 0, "left": 0, "right": 0}
c.statusbar.show = 'in-mode'
c.statusbar.widgets = [
    'keypress', 'search_match', 'url', 'progress',
]

# Completion UI
c.completion.scrollbar.width = 0
c.completion.height = '16%'
c.completion.shrink = True

# Cursor
c.qt.environ = {'XCURSOR_THEME': 'capitaine-cursors', 'XCURSOR_SIZE': '32'}

# ============================================================================
# THEME SYSTEM
# ============================================================================

ACTIVE_THEME = 'material'

def apply_theme(theme_name):
    """Apply selected theme to Qutebrowser UI"""

    themes = {
        'gruvbox': {
            # Typické gruvbox: teplé béžové fg, zlatý akcent, oranžový insert
            'bg': '#282828', 'bg_light': '#3c3836',
            'fg': '#ebdbb2',        # béžová — hlavní text
            'fg_dim': '#928374',    # šedohnědá — neaktivní taby
            'accent1': '#d79921',   # zlatá — aktivní tab, completion selected
            'accent2': '#d65d0e',   # oranžová — sekundární akcent
            'insert': '#98971a',    # olivová — insert mode
            'selected_fg': '#1d2021',  # skoro černá — text na zlatém tabu
            'css': 'gruvbox.css'
        },
        'catppuccin-mocha': {
            # Catppuccin: tmavé pozadí, pastelové barvy, fialový akcent
            'bg': '#1e1e2e', 'bg_light': '#313244',
            'fg': '#b9a0e8',        # světle fialová — tématická
            'fg_dim': '#6c7086',    # tlumená šedofialová — neaktivní taby
            'accent1': '#cba6f7',   # levandulová — aktivní tab
            'accent2': '#89b4fa',   # modrá — sekundární
            'insert': '#a6e3a1',    # zelená — insert mode
            'selected_fg': '#1e1e2e',  # tmavé pozadí — text na levandulové
            'css': 'catppuccin-mocha.css'
        },
        'catppuccin': {
            # Catppuccin (non-mocha): výraznější růžovofialová, sytější než mocha
            'bg': '#1e1e2e', 'bg_light': '#302d41',
            'fg': '#c4a0c8',        # sytější růžovofialová — odlišná od mocha
            'fg_dim': '#5a4a6a',    # tmavá fialová — neaktivní taby
            'accent1': '#ff5999',   # výrazná růžová — aktivní tab
            'accent2': '#9d4edd',   # sytá fialová — sekundární
            'insert': '#a6e3a1',    # zelená — insert mode
            'selected_fg': '#1e1e2e',  # tmavé pozadí — text na růžové
            'css': 'catppuccin.css'
        },
        'nord': {
            # Nord: ledově modrá, minimalistické, chladné tóny
            'bg': '#2e3440', 'bg_light': '#3b4252',
            'fg': '#8fbcbb',        # ledová tyrkysová — tématická
            'fg_dim': '#4c566a',    # tmavší šedá — neaktivní taby
            'accent1': '#88c0d0',   # ledová modrá — aktivní tab
            'accent2': '#81a1c1',   # středně modrá — sekundární
            'insert': '#a3be8c',    # severská zelená — insert mode
            'selected_fg': '#2e3440',  # tmavé pozadí — text na ledové modré
            'css': 'nord.css'
        },
        'tokyo-night': {
            # Tokyo Night: tmavě námořní, neonové modrofialové akcenty
            'bg': '#1a1b26', 'bg_light': '#24283b',
            'fg': '#5d6894',        # sytá modrofialová — tématická, ne šedá
            'fg_dim': '#2e3354',    # tmavá námořní — neaktivní taby
            'accent1': '#7aa2f7',   # neonová modrá — aktivní tab
            'accent2': '#bb9af7',   # fialová — sekundární
            'insert': '#9ece6a',    # neonová zelená — insert mode
            'selected_fg': '#1a1b26',  # tmavé pozadí — text na neonové modré
            'css': 'tokyo-night.css'
        },
        'rose-pine': {
            # Rosé Pine: tlumená, zemitě fialová, romantická
            'bg': '#191724', 'bg_light': '#26233a',
            'fg': '#9a7fa0',        # střední růžovofialová — čitelná, tématická
            'fg_dim': '#524869',    # tlumená fialová — neaktivní taby
            'accent1': '#c4a7e7',   # světle fialová — aktivní tab
            'accent2': '#ebbcba',   # růžová — sekundární
            'insert': '#9ccfd8',    # mátová — insert mode
            'selected_fg': '#191724',  # tmavé pozadí — text na fialové
            'css': 'rose-pine.css'
        },
        'rose-pine-moon': {
            # Rosé Pine Moon: výrazně tmavší, chladnější než Pine
            'bg': '#0f0e17', 'bg_light': '#1a1826',
            'fg': '#6d6582',        # tmavší fialová šedá — střízlivá, tématická
            'fg_dim': '#2e2b3d',    # velmi tmavá fialová — neaktivní taby
            'accent1': '#ea9a97',   # lososová — aktivní tab
            'accent2': '#3e8fb0',   # tmavá tyrkysová — sekundární
            'insert': '#9ccfd8',    # mátová — insert mode
            'selected_fg': '#0f0e17',  # velmi tmavé — text na lososové
            'css': 'rose-pine-moon.css'
        },
        'monokai': {
            # Monokai: upraveno na příjemnou modrou paletu
            'bg': '#272822', 'bg_light': '#3e3d32',
            'fg': '#a8b8d0',        # světle modravá — hlavní text
            'fg_dim': '#5f6e82',    # tlumená modravá — neaktivní taby
            'accent1': '#66d9ef',   # cyan — aktivní tab
            'accent2': '#ae81ff',   # fialová — sekundární
            'insert': '#a6e22e',    # zelená — insert mode
            'selected_fg': '#272822',  # tmavé pozadí — text na cyanu
            'css': 'monokai.css'
        },
        'everforest': {
            # Everforest: přírodní, tlumené zelené tóny
            'bg': '#2d353b', 'bg_light': '#343f44',
            'fg': '#9dba8a',        # tlumená lesní zelená — tématická
            'fg_dim': '#859289',    # šedozelená — neaktivní taby
            'accent1': '#a7c080',   # lesní zelená — aktivní tab
            'accent2': '#dbbc7f',   # zlatohnědá — sekundární
            'insert': '#83c092',    # světlejší zelená — insert mode
            'selected_fg': '#2d353b',  # tmavé pozadí — text na zelené
            'css': 'everforest.css'
        },
        'solarized': {
            # Solarized Dark: vědecky navržené kontrasty, cyan akcenty
            'bg': '#002b36', 'bg_light': '#073642',
            'fg': '#2aa198',        # solarized cyan — tématická
            'fg_dim': '#586e75',    # tlumená šedá — neaktivní taby
            'accent1': '#268bd2',   # modrá — aktivní tab
            'accent2': '#2aa198',   # cyan — sekundární
            'insert': '#859900',    # olivová — insert mode
            'selected_fg': '#fdf6e3',  # světlé krémové — text na modré (kontrast)
            'css': 'solarized.css'
        },
        'material': {
            # Material Dark: teplá, světle hnědá fg, oranžový akcent
            'bg': '#212121', 'bg_light': '#2e2e2e',
            'fg': '#c8b99a',        # světle hnědá — hlavní text
            'fg_dim': '#7a6a58',    # tmavší hnědá — neaktivní taby
            'accent1': '#ffab40',   # jantarová — aktivní tab
            'accent2': '#ff7043',   # oranžovočervená — sekundární
            'insert': '#aed581',    # světle zelená — insert mode
            'selected_fg': '#212121',  # tmavé pozadí — text na jantarové
            'css': 'material.css'
        },
    }

    if theme_name not in themes:
        print(f"⚠️  Theme '{theme_name}' doesn't exist!")
        print(f"Available: {', '.join(themes.keys())}")
        return

    t = themes[theme_name]

    # Completion menu
    c.colors.completion.fg = t['fg']
    c.colors.completion.odd.bg = t['bg']
    c.colors.completion.even.bg = t['bg']
    c.colors.completion.category.fg = t['accent1']
    c.colors.completion.category.bg = t['bg_light']
    c.colors.completion.item.selected.fg = t['selected_fg']
    c.colors.completion.item.selected.bg = t['accent1']

    # Statusbar
    c.colors.statusbar.normal.fg = t['fg']
    c.colors.statusbar.normal.bg = t['bg']
    c.colors.statusbar.insert.fg = t['selected_fg']
    c.colors.statusbar.insert.bg = t['insert']
    c.colors.statusbar.command.fg = t['fg']
    c.colors.statusbar.command.bg = t['bg_light']

    # Tabs — neaktivní taby mají fg_dim (tématická tlumená barva)
    c.colors.tabs.even.bg = t['bg']
    c.colors.tabs.odd.bg = t['bg']
    c.colors.tabs.even.fg = t['fg_dim']
    c.colors.tabs.odd.fg = t['fg_dim']
    c.colors.tabs.selected.even.bg = t['accent1']
    c.colors.tabs.selected.odd.bg = t['accent1']
    c.colors.tabs.selected.even.fg = t['selected_fg']
    c.colors.tabs.selected.odd.fg = t['selected_fg']

    # Dynamically load CSS files
    css_files = [
        os.path.expanduser('~/.config/qutebrowser/css/custom.css'),
        os.path.expanduser('~/.config/qutebrowser/css/youtube.css'),
    ]

    if 'css' in t:
        theme_css = os.path.expanduser(f'~/.config/qutebrowser/css/{t["css"]}')
        if os.path.exists(theme_css):
            css_files.append(theme_css)

    c.content.user_stylesheets = css_files

# Load startup theme
apply_theme(ACTIVE_THEME)
