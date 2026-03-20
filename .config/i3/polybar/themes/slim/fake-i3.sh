#!/bin/bash

# 1. Batas 9 Workspace
workspaces=("1" "2" "3" "4" "5" "6" "7" "8" "9")
workspaces_oc=("¹" "²" "³" "⁴" "⁵" "⁶" "⁷" "⁸" "⁹")
workspaces_empty=("¹" "²" "3" "4" "5" "6" "7" "8" "9")

# 2. Ambil data mentah dari i3
ws_data=$(i3-msg -t get_workspaces)

# 3. Ambil nama workspace yang FOCUSED
focused=$(echo "$ws_data" | jq -r '.[] | select(.focused==true).name')

output=""

for ws in "${workspaces[@]}"; do
    action="%{A1:i3-msg workspace $ws:}"
    end_action="%{A}"

    # Cek apakah workspace ini ada di dalam daftar yang 'ada' (occupied)
    is_occupied=$(echo "$ws_data" | jq -r '.[].name' | grep -x "$ws")

    if [ "$ws" == "$focused" ]; then
        # AKTIF: Orange + Underline
        #output+="$action%{F#000000}%{B#bb9af7}%{u#ffffff}%{+u} $ws %{-u}%{B-}%{F-}$end_action"
        output+="$action%{F#000000}%{B#bb9af7} $ws %{B-}%{F-}$end_action"
    elif [ -n "$is_occupied" ]; then
        # BERISI: Background Abu-abu + Teks Putih (Harus terlihat beda!)
        #output+="$action%{F#ffffff}%{u#bb9af7}%{+u}%{B#444444} $ws %{B-}%{-u}%{F-}$end_action "
        #output+="$action%{F#ffffff}%{B#643CAA}%{u#FFFFFF}%{+u} $ws %{-u}%{B-}%{F-}$end_action"
        output+="$action%{F#ffffff}%{B#643CAA} $ws %{B-}%{F-}$end_action"
    else
        # KOSONG: Hanya teks redup, tanpa background
        output+="$action%{F#8D6BC9}%{B#2B174F} $ws %{B-}%{F-}$end_action"
    fi
    # Add gaps / separator here
    output+="%{F#ffffff}%{F-}"
done

echo "$output"
