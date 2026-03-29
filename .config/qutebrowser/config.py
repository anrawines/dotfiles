# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

import os
os.environ['ROFI_CMD'] = 'rofi'

# MUSÍ BÝT PRVNÍ
config.load_autoconfig(False)

# ============================================================================
# BASIC SETTINGS
# ============================================================================

c.session.lazy_restore = True

c.window.title_format = '{perc}{current_title}{title_sep}qutebrowser'

c.aliases = {
    'q': 'quit --save',
    'w': 'session-save',
    'wq': 'quit --save',
}

c.auto_save.session = True
c.auto_save.interval = 15000
c.session.default_name = 'main'

c.zoom.default = '175%'
c.zoom.levels = [
    "25%", "33%", "50%", "67%", "75%", "90%", "100%", "110%", "120%",
    "130%", "140%", "150%", "175%", "200%", "250%", "300%",
]

c.editor.command = ['alacritty', '-e', 'vim', '{file}']

# Hints
c.hints.chars = 'asdfghjkl'
c.hints.auto_follow = 'unique-match'
c.hints.auto_follow_timeout = 0
c.hints.leave_on_load = True

# ============================================================================
# LOAD MODULES
# ============================================================================

config.source('appearance.py')
config.source('content.py')
config.source('keybindings.py')
config.source('search.py')
config.source('downloads.py')

# ============================================================================
# END OF CONFIG
# ============================================================================
