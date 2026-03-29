# ============================================================================
# ZÁKLADNÍ OPERACE - UNDO, NAVIGACE, REFRESH
# ============================================================================

# Obnovit zavřenou záložku
config.bind('u', 'undo')

# Navigace mezi záložkami (J/K = vim style)
config.bind('J', 'tab-prev')              # J = předchozí záložka
config.bind('K', 'tab-next')              # K = následující záložka

# Navigace v historii (H/L = vim style)
config.bind('H', 'back')                  # H = zpět v historii
config.bind('L', 'forward')               # L = dopředu v historii

# Přepnutí mezi poslední dvěma otevřenými záložkami
config.bind('<Ctrl-Tab>', 'tab-focus last')

# Reload bez cache (obejde cached verzi)
config.bind('<Ctrl-Shift-r>', 'reload --force')

# Tisk stránky
config.bind('<Ctrl-p>', 'print')


# ============================================================================
# VYHLEDÁVACÍ ZKRATKY (QUICKMARKS)
# ============================================================================

c.url.searchengines.update({
    '!dd': 'https://duckduckgo.com/?q={}',      # !dd = DuckDuckGo vyhledávání
    '!map': 'https://www.google.com/maps/search/{}',  # !map = Google Mapy
})


# ============================================================================
# SCROLLOVÁNÍ & PŘIBLÍŽENÍ
# ============================================================================

# Scrollování (j/k = vim style)
config.bind('j', 'scroll-px 0 130')       # j = scroll dolů
config.bind('k', 'scroll-px 0 -130')      # k = scroll nahoru

# Přiblížení/oddálení
config.bind('<Ctrl-=>', 'zoom-in', mode='normal')    # Ctrl++ = zvětšit
config.bind('<Ctrl-->', 'zoom-out', mode='normal')   # Ctrl+- = zmenšit
config.bind('<Ctrl-/>', 'zoom')                      # Ctrl+/ = reset zoomu


# ============================================================================
# SPRÁVA ZÁLOŽEK - PŘESOUVÁNÍ A PŘEPÍNÁNÍ
# ============================================================================

# Přesun záložky vlevo/vpravo
config.bind('<Ctrl-k>', 'tab-move +')     # Ctrl+K = posunout záložku vpravo
config.bind('<Ctrl-j>', 'tab-move -')     # Ctrl+J = posunout záložku vlevo

# Přímý skok na konkrétní záložku (Ctrl+1-0)
config.bind('<Ctrl-1>', 'tab-focus 1')
config.bind('<Ctrl-2>', 'tab-focus 2')
config.bind('<Ctrl-3>', 'tab-focus 3')
config.bind('<Ctrl-4>', 'tab-focus 4')
config.bind('<Ctrl-5>', 'tab-focus 5')
config.bind('<Ctrl-6>', 'tab-focus 6')
config.bind('<Ctrl-7>', 'tab-focus 7')
config.bind('<Ctrl-8>', 'tab-focus 8')
config.bind('<Ctrl-9>', 'tab-focus 9')
config.bind('<Ctrl-0>', 'tab-focus 10')

# Přímý skok na konkrétní záložku (Ctrl + české znaky na horní řadě)
config.bind('<Ctrl-+>', 'tab-focus 1')
config.bind('<Ctrl-ě>', 'tab-focus 2')
config.bind('<Ctrl-š>', 'tab-focus 3')
config.bind('<Ctrl-č>', 'tab-focus 4')
config.bind('<Ctrl-ř>', 'tab-focus 5')
config.bind('<Ctrl-ž>', 'tab-focus 6')
config.bind('<Ctrl-ý>', 'tab-focus 7')
config.bind('<Ctrl-á>', 'tab-focus 8')
config.bind('<Ctrl-í>', 'tab-focus 9')
config.bind('<Ctrl-é>', 'tab-focus 10')

# Fullscreen/Zen režim (skrýt statusbar a záložky)
config.bind('<Ctrl-Return>',
            'config-cycle statusbar.show always never;; '
            'config-cycle tabs.show always never')


# ============================================================================
# OTEVÍRÁNÍ STRÁNEK - RYCHLÉ ZKRATKY (X PREFIX)
# ============================================================================

# Otevřít v nové záložce (x + písmeno)
config.bind('xk', 'open -t calendar.google.com')     # xk = Google Calendar
config.bind('xt', 'open -t translate.google.com')    # xt = Google Translate
config.bind('xa', 'open -t perplexity.ai')           # xa = Perplexity AI
config.bind('xc', 'open -t claude.ai')               # xc = Claude AI
config.bind('xb', 'open -t youtube.com')             # xb = YouTube
config.bind('xm', 'open -t mrkaj.si')                # xm = Mrkaj.si
config.bind('xw', 'open -t twitch.tv')               # xw = Twitch
config.bind('xf', 'open -t example.com')             # xf = vlastní stránka
config.bind('xs', 'open -t example.com')             # xs = vlastní stránka


# ============================================================================
# OTEVÍRÁNÍ URL / HLEDÁNÍ
# ============================================================================

# Otevřít novou záložku se zadáním URL
config.bind('t', 'cmd-set-text -s :open')           # t = otevřít v současné záložce
config.bind('o', 'cmd-set-text -s :open -t')        # o = otevřít v nové záložce

# Zobrazit historii
config.bind('h', 'history')                          # h = zobrazit historii


# ============================================================================
# VYHLEDÁVÁNÍ & PŘEKLAD - RESEARCH PREFIX (COMMA+LETTER)
# ============================================================================

# Vyhledávání vybraného textu
config.bind(',a', 'spawn --userscript ares_search')          # ,a = Ares vyhledávání
config.bind(',g', 'spawn --userscript search-selected-google') # ,g = Google vyhledávání

# Překlad a čtení stránky
config.bind(',v', 'open -t https://r.jina.ai/{url}')        # ,v = Jina Reader (očisti stránku)
config.bind(',t', 'open -t https://translate.google.com/translate?sl=auto&tl=cs&u={url}')

# ============================================================================
# NÁSTROJE - KALKULÁTOR, PSANÍ, STAŽENÍ (COMMA+LETTER)
# ============================================================================

# Praktické nástroje
config.bind(',s', 'spawn --userscript sum_selected')         # ,s = sečti vybraná čísla
config.bind(',c', 'spawn --userscript convert_currency')     # ,c = převod měny
config.bind(',d', 'spawn --userscript open_download_dmenu')  # ,d = otevřít stažené soubory
config.bind(',x', 'spawn --userscript open_in_calc')         # ,x = otevřít kalkulátor
config.bind(',w', 'spawn --userscript open_in_writer')       # ,w = otevřít psaní
config.bind(',R', 'spawn --userscript readability')          # ,R = režim čtení (čistý text)
config.bind(',r', 'spawn --userscript raindrop')
#config.bind(',o', 'spawn --userscript open_last_download', mode='normal') # download menu s rofi
config.bind(',o', 'config-cycle zoom.default 150% 175% 200%')

# ============================================================================
# SPRÁVA HESEL - BITWARDEN (COMMA+P/U)
# ============================================================================

config.bind(',p', 'spawn --userscript qute-bitwarden --dmenu-invocation "dmenu -p Bitwarden"')  # ,p = celý přihlašovací údaj
config.bind(',P', 'spawn --userscript qute-bitwarden --password-only --dmenu-invocation "dmenu -p Heslo"')  # ,P = jen heslo
config.bind(',u', 'spawn --userscript qute-bitwarden --username-only --dmenu-invocation "dmenu -p Login"')  # ,u = jen uživatelské jméno


# ============================================================================
# PŘEHRÁVÁNÍ VIDEA - MPV (SPACE+F/J)
# ============================================================================

# Přehrát video přes MPV (optimalizované pro YouTube do 1080p)
#config.bind(',m', 'hint links spawn mpv {hint-url}')

c.hints.leave_on_load = False
c.hints.auto_follow_timeout = 0

# freetube
#config.bind(',M', 'hint links spawn freetube {hint-url}')

# MPV
#config.bind(',m', 'hint links spawn mpv --hwdec=nvdec --cache=yes --demuxer-max-bytes=50MiB --demuxer-readahead-secs=30 --video-sync=audio --ytdl-raw-options=cookies-from-browser=chrome {hint-url}')
#config.bind(',m', 'hint links spawn /usr/bin/mpv --cache=yes  --demuxer-max-bytes=50MiB --demuxer-readahead-secs=30 --video-sync=audio --ytdl-format="bestvideo[height<=720]+bestaudio/best[height<=720]" {hint-url}')
config.bind(',m', 'hint links spawn /usr/local/bin/mpv-history {hint-url}')
config.bind(',M', 'spawn --userscript mpv-pick-history')

# ============================================================================
# KONFIGURACE & DEBUG (COMMA+C)
# ============================================================================

# Editace konfigurace
config.bind(',ce', 'config-edit')                    # ,ce = editovat config
config.bind(',b', 'spawn --userscript show_binds')   # ,b = zobrazit všechny bindingu
config.bind(',cr', 'config-source ;; message-info "Config reloaded!"')  # ,cr = načíst config znovu


# ============================================================================
# MAKRA - DEAKTIVOVÁNY (NAHRAZENI QUIT)
# ============================================================================

# Zrušit makra (q na záznam, @ na přehrání)
config.unbind('q', mode='normal')
config.unbind('@', mode='normal')

# Přiřadit 'q' na uzavření s uložením sezení
config.bind('q', 'quit --save', mode='normal')  # q = ukončit a uložit sezení
