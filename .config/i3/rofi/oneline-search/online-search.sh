#!/usr/bin/env bash

# Get script directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Rofi configuration
ROFI_OPTIONS="-dmenu -p Search"
ROFI_THEME="-theme $DIR/online-search.rasi"
ROFI_MSG="<b>i</b> image | <b>r</b> reddit | <b>y</b> youtube | <b>g</b> github | <b>x</b> yandex | <b>xx</b> twitter"



# Get user input
QUERY=$(echo "" | rofi $ROFI_OPTIONS $ROFI_THEME -mesg "$ROFI_MSG" | tr -d '\n')

# Exit if empty
if [ -z "$QUERY" ]; then
    exit 0
fi

# Define search engines
if [[ $QUERY == i\ * ]]; then
    # Image search
    SEARCH_QUERY=$(echo "${QUERY#i }" | sed 's/ /+/g')
    URL="https://www.google.com/search?tbm=isch&q=${SEARCH_QUERY}"
elif [[ $QUERY == r\ * ]]; then
    # Reddit search
    SEARCH_QUERY=$(echo "${QUERY#r }" | sed 's/ /+/g')
    URL="https://www.reddit.com/search/?q=${SEARCH_QUERY}"
elif [[ $QUERY == y\ * ]]; then
    # Youtube search
    SEARCH_QUERY=$(echo "${QUERY#y }" | sed 's/ /+/g')
    URL="https://www.youtube.com/results?search_query=${SEARCH_QUERY}"
elif [[ $QUERY == g\ * ]]; then
    # Github search
    SEARCH_QUERY=$(echo "${QUERY#g }" | sed 's/ /+/g')
    URL="https://github.com/search?q=${SEARCH_QUERY}"
elif [[ $QUERY == x\ * ]]; then
    # Yandex search
    SEARCH_QUERY=$(echo "${QUERY#x }" | sed 's/ /+/g')
    URL="https://yandex.ru/images/search?text=${SEARCH_QUERY}&isize=large"
elif [[ $QUERY == xx\ * ]]; then
    # X/Twitter Search
    SEARCH_QUERY=$(echo "${QUERY#xx }" | sed 's/ /+/g')
    URL="https://twitter.com/search?q=${SEARCH_QUERY}"
else
    # Default/Fallback to Google
    SEARCH_QUERY=$(echo "$QUERY" | sed 's/ /+/g')
    URL="https://www.google.com/search?q=${SEARCH_QUERY}"
fi

# Open in default browser
firefox "$URL" &
i3-msg '[class="firefox"] focus'
