#!/usr/bin/env bash

LOGO_DIR="$HOME/nixos-dotfiles/config/fastfetch/logos"
USED_FILE="$HOME/nixos-dotfiles/config/fastfetch/used_logos.txt"

fastfetch_random() {

    if [ ! -d "$LOGO_DIR" ]; then
        echo "No such diretory as: $LOGO_DIR"
        return 1
    fi

    mapfile -t all_logos < <(ls -1 "$LOGO_DIR")

    if [ "${#all_logos[@]}" -eq 0 ]; then
        echo "The folder is empty $LOGO_DIR"
        return 1
    fi

    if [ -f "$USED_FILE" ]; then
        mapfile -t used_logos < "$USED_FILE"
    else
        used_logos=()
    fi

    unused_logos=()
    for logo in "${all_logos[@]}"; do
        if ! printf '%s\n' "${used_logos[@]}" | grep -qx "$logo"; then
            unused_logos+=("$logo")
        fi
    done

    if [ "${#unused_logos[@]}" -eq 0 ]; then
        unused_logos=("${all_logos[@]}")
        : > "$USED_FILE"
    fi

    rand_index=$(( RANDOM % ${#unused_logos[@]} ))
    LOGO="${unused_logos[$rand_index]}"

    echo "$LOGO" >> "$USED_FILE"

    fastfetch --logo "$LOGO_DIR/$LOGO"
}

fastfetch_random
