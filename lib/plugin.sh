#!/usr/bin/env bash
# Plugin list (convention: plugins/<name>/<name>.plugin.sh)

cbash_list_plugins() {
    echo "Core Plugins:"
    find "$CBASH_DIR/plugins" -name "*.plugin.sh" 2>/dev/null | sort | while IFS= read -r f; do
        [[ -f "$f" ]] && basename "$(dirname "$f")"
    done
    echo ""
    echo "Custom Plugins:"
    [[ -d "$CBASH_DIR/custom/plugins" ]] && find "$CBASH_DIR/custom/plugins" -name "*.plugin.sh" 2>/dev/null | sort | while IFS= read -r f; do
        [[ -f "$f" ]] && basename "$(dirname "$f")"
    done
}
