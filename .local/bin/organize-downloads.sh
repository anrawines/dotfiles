#!/usr/bin/env bash
# =============================================================================
# organize_downloads.sh
# Organizes ~/Downloads into categorized subfolders.
# Usage: bash organize_downloads.sh [--dry-run]
# =============================================================================

set -uo pipefail   # Note: no -e, because ((n++)) returns 1 when n=0 which kills the script

# ── Config ────────────────────────────────────────────────────────────────────
DOWNLOAD_DIR="$HOME/Downloads"
DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

# ── Category → extensions mapping ────────────────────────────────────────────
declare -A CATEGORIES=(
  [Images]="jpg jpeg png gif bmp svg webp tiff tif ico heic heif raw cr2 nef"
  [Videos]="mp4 mkv avi mov wmv flv webm m4v mpeg mpg 3gp ts vob"
  [Documents]="pdf doc docx xls xlsx ppt pptx txt md csv odt ods odp rtf epub pages numbers key"
  [Scripts]="sh bash py js ts rb pl php lua go rs swift java c cpp h cs json"
  [Compressed]="zip tar gz bz2 xz 7z rar tgz tbz2 zst"
  [Binaries]="exe msi dmg deb rpm AppImage apk pkg run bin out"
  [Others]=""   # catch-all
)

# Ordered list (Others must be last)
ORDERED_CATS=(Images Videos Documents Scripts Compressed Binaries Others)

# ── Helpers ───────────────────────────────────────────────────────────────────
log()  { echo "  $*"; }
move() {
  local src="$1" dest_dir="$2"
  local dest="$dest_dir/$(basename "$src")"

  # Avoid overwriting: append counter if name already exists
  if [[ -e "$dest" ]]; then
    local base ext name counter=1
    base=$(basename "$src")
    ext="${base##*.}"
    name="${base%.*}"
    # handle files with no extension
    [[ "$ext" == "$base" ]] && ext="" && name="$base"
    while [[ -e "$dest" ]]; do
      [[ -n "$ext" ]] && dest="$dest_dir/${name}_${counter}.${ext}" \
                      || dest="$dest_dir/${name}_${counter}"
      ((counter++))
    done
  fi

  if $DRY_RUN; then
    log "[DRY-RUN] $(basename "$src")  →  ${dest_dir##*/}/"
  else
    mv -- "$src" "$dest"
    log "$(basename "$dest")  →  ${dest_dir##*/}/"
  fi
}

get_category() {
  local file="$1"
  local ext="${file##*.}"
  ext="${ext,,}"   # lowercase

  for cat in "${ORDERED_CATS[@]}"; do
    [[ "$cat" == "Others" ]] && continue
    for e in ${CATEGORIES[$cat]}; do
      [[ "$ext" == "$e" ]] && echo "$cat" && return
    done
  done
  echo "Others"
}

# ── Main ──────────────────────────────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════"
echo "  Downloads Organizer"
$DRY_RUN && echo "  ⚠  DRY-RUN mode — no files will be moved"
echo "  Folder: $DOWNLOAD_DIR"
echo "═══════════════════════════════════════════"
echo ""

if [[ ! -d "$DOWNLOAD_DIR" ]]; then
  echo "Error: '$DOWNLOAD_DIR' not found." >&2
  exit 1
fi

# Create destination subdirectories (skip in dry-run)
for cat in "${ORDERED_CATS[@]}"; do
  dest="$DOWNLOAD_DIR/$cat"
  if ! $DRY_RUN; then
    mkdir -p "$dest"
  fi
done

moved=0

# Iterate over files in root of Downloads only (not subdirectories)
while IFS= read -r -d '' file; do
  filename=$(basename "$file")

  # Skip this script itself, hidden files, and our own category folders
  [[ "$filename" == "organize_downloads.sh" ]] && continue
  [[ "$filename" == .* ]] && continue

  cat=$(get_category "$filename")
  dest_dir="$DOWNLOAD_DIR/$cat"

  move "$file" "$dest_dir"
  moved=$((moved + 1))

done < <(find "$DOWNLOAD_DIR" -maxdepth 1 -type f -print0)

echo ""
echo "─────────────────────────────────────────────"
if $DRY_RUN; then
  echo "  Would move : $moved file(s)"
  echo "  Re-run without --dry-run to apply changes."
else
  echo "  ✓ Done! Moved $moved file(s)."
fi
echo "─────────────────────────────────────────────"
echo ""
