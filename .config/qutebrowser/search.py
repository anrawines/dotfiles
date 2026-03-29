# ============================================================================
# START PAGE & SEARCH
# ============================================================================

import os

start_page = 'file://' + os.path.expanduser('~/.local/share/qutebrowser/startpage/index.html')
c.url.start_pages = [start_page]
c.url.default_page = start_page

c.url.open_base_url = True
c.url.auto_search = 'naive'

c.url.searchengines = {
    'DEFAULT': 'https://www.google.com/search?q={}',
    'cl': 'https://claude.ai/new?q={}',
    'pp': 'https://www.perplexity.ai/search?q={}',
    'aw': 'https://wiki.archlinux.org/?search={}',
    'apkg': 'https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=',
    'aur': 'https://aur.archlinux.org/packages?K={}',
    'gh': 'https://github.com/search?o=desc&q={}&s=stars',
    'yt': 'https://www.youtube.com/results?search_query={}',
    'm': 'https://mapy.com/search?q={}&source=home',
}
