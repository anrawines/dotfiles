# ============================================================================
# FONTS
# ============================================================================

c.fonts.default_family = '"Commit Mono"'
c.fonts.default_size = '14pt'
c.fonts.completion.entry = '14pt "Commit Mono"'
c.fonts.debug_console = '14pt "Commit Mono"'
c.fonts.prompts = 'default_size default_family'
c.fonts.statusbar = '12pt "Commit Mono"'

# ============================================================================
# AD & TRACKER BLOCKING
# ============================================================================

c.content.blocking.enabled = True
c.content.blocking.method = 'both'
c.content.blocking.hosts.block_subdomains = True
c.content.prefers_reduced_motion = True

# AdBlock lists
c.content.blocking.adblock.lists = [
    'https://easylist.to/easylist/easylist.txt',
    'https://easylist.to/easylist/easyprivacy.txt',
    'https://easylist-downloads.adblockplus.org/easylistczechslovak.txt',
    'https://easylist-downloads.adblockplus.org/easylistczechslovak+easylist.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt',
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt'
]

# Host-based blocking
c.content.blocking.hosts.lists = [
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts',
]

# Whitelist
c.content.blocking.whitelist = [
    '*.seznam.cz',
    'login.szn.cz',
    '*.mapy.cz',
    '*.mapy.com',
    '*.youtube.com',
    '*.googlevideo.com',
    '*.ytimg.com',
    '*.ggpht.com',
    '*.googleusercontent.com',
]

# Disable blocking for specific patterns
config.set('content.blocking.enabled', False, 'file://*')
config.set('content.blocking.enabled', False, 'https://perplexity.ai/*')
config.set('content.blocking.enabled', False, 'https://twitch.tv/*')

# ============================================================================
# PRIVACY & SECURITY
# ============================================================================

c.content.headers.do_not_track = True
c.content.headers.accept_language = 'en-US,cs;q=0.9,en;q=0.8'
c.content.canvas_reading = False
c.content.geolocation = False
c.content.webrtc_ip_handling_policy = 'default-public-interface-only'
c.content.dns_prefetch = True
c.content.tls.certificate_errors = 'ask-block-thirdparty'
c.content.hyperlink_auditing = False
c.content.fullscreen.window = True
c.content.pdfjs = False

c.input.escape_quits_reporter = True
c.input.insert_mode.auto_enter = True
c.input.insert_mode.auto_leave = True
c.input.insert_mode.auto_load = False

c.content.media.audio_capture = False
c.content.media.video_capture = False

c.content.unknown_url_scheme_policy = 'allow-from-user-interaction'
c.content.register_protocol_handler = False

c.url.searchengines['webcal'] = 'https://calendar.google.com/calendar/r?cid={}'
c.url.incdec_segments = ['path', 'query']

# Cache
c.content.cache.size = 52428800  # 50MB

# ============================================================================
# USER AGENT & HEADERS
# ============================================================================

# Global Chrome UA (Windows)
c.content.headers.user_agent = (
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
    'AppleWebKit/537.36 (KHTML, like Gecko) '
    'Chrome/132.0.0.0 Safari/537.36'
)

# Per-site overrides
firefox_ua = (
    'Mozilla/5.0 (X11; Linux x86_64; rv:128.0) '
    'Gecko/20100101 Firefox/128.0'
)
chrome_ua_linux = (
    'Mozilla/5.0 (X11; Linux x86_64) '
    'AppleWebKit/537.36 (KHTML, like Gecko) '
    'Chrome/132.0.0.0 Safari/537.36'
)
chrome_ua_win = (
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
    'AppleWebKit/537.36 (KHTML, like Gecko) '
    'Chrome/132.0.0.0 Safari/537.36'
)

config.set('content.headers.user_agent', firefox_ua, 'https://accounts.google.com/*')
config.set('content.headers.user_agent', firefox_ua, 'https://docs.google.com/*')
config.set('content.headers.user_agent', firefox_ua, 'https://drive.google.com/*')
config.set('content.headers.user_agent', chrome_ua_linux, 'https://*.slack.com/*')
config.set('content.headers.user_agent', chrome_ua_win, 'login.szn.cz')
config.set('content.headers.user_agent', chrome_ua_linux, 'https://perplexity.ai/*')
config.set('content.headers.user_agent', chrome_ua_win, 'https://twitch.tv/*')

# Special Google UA (you may want to reconsider this - seems redundant with global)
ua_google = (
    'Mozilla/5.0 (X11; Linux x86_64) '
    'AppleWebKit/537.36 (KHTML, like Gecko) '
    'Chrome/132.0.0.0 Safari/537.36'
)

config.set('content.headers.user_agent', ua_google, '*://*.google.com/*')

# ============================================================================
# COOKIES & COMPLETION
# ============================================================================

config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')

c.completion.web_history.max_items = 10000
c.completion.web_history.exclude = [
    'https://accounts.google.com/*',
    '*://*/login',
    '*://*/signin',
    '*://*/auth/*',
    'https://www.pornhub.com/*',
]
c.completion.open_categories = [
    'searchengines', 'quickmarks', 'bookmarks', 'history', 'filesystem',
]
c.completion.use_best_match = True

# ============================================================================
# JAVASCRIPT & MEDIA
# ============================================================================

c.content.javascript.enabled = True
c.content.javascript.modal_dialog = False
c.content.javascript.can_open_tabs_automatically = False
c.content.javascript.clipboard = 'access'

# JS exceptions (these are mostly redundant - JS is enabled globally)
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

# Media / images
c.content.autoplay = False
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')

c.content.webgl = False
config.set('content.webgl', True, '*.youtube.com')
config.set('content.webgl', True, '*://*.google.com/*')

# Notifications
c.content.notifications.enabled = False
config.set('content.notifications.enabled', True, 'https://web.whatsapp.com/')
config.set('content.notifications.enabled', True, 'https://calendar.google.com/')

# ============================================================================
# HARDWARE ACCELERATION & PERFORMANCE
# ============================================================================

c.qt.args = [
    '--disable-gpu-compositing',   # Fix: zabraňuje problikávání při přehrávání videa
    '--ignore-gpu-blocklist',
    '--enable-accelerated-video-decode',
    '--disable-vulkan',
]

c.qt.highdpi = True
c.qt.chromium.sandboxing = 'enable-all'
c.qt.chromium.low_end_device_mode = 'auto'
