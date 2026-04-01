#!/system/bin/sh

SWAP_PATH="/data/local/tmp/swapfile"

if [ -f "$SWAP_PATH" ]; then
    swapoff "$SWAP_PATH" 2>/dev/null
    rm -f "$SWAP_PATH"
fi
