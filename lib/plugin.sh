#!/usr/bin/env bash

# Simple Plugin System (Oh-My-Zsh Style)
# Convention-based plugin loading without JSON dependencies

# Load a single plugin
cbash_load_plugin() {
    local plugin_name="$1"
    local plugin_file
    
    # Check custom plugins first, then core plugins
    if [[ -f "$CBASH_DIR/custom/plugins/$plugin_name/$plugin_name.plugin.sh" ]]; then
        plugin_file="$CBASH_DIR/custom/plugins/$plugin_name/$plugin_name.plugin.sh"
    elif [[ -f "$CBASH_DIR/plugins/$plugin_name/$plugin_name.plugin.sh" ]]; then
        plugin_file="$CBASH_DIR/plugins/$plugin_name/$plugin_name.plugin.sh"
    else
        return 1
    fi
    
    # Source the plugin file
    source "$plugin_file"
    return 0
}

# Load multiple plugins
cbash_load_plugins() {
    local plugin
    for plugin in "$@"; do
        cbash_load_plugin "$plugin" || echo "Warning: plugin '$plugin' not found" >&2
    done
}

# Check if plugin exists
cbash_plugin_exists() {
    local plugin_name="$1"
    [[ -f "$CBASH_DIR/custom/plugins/$plugin_name/$plugin_name.plugin.sh" ]] || \
    [[ -f "$CBASH_DIR/plugins/$plugin_name/$plugin_name.plugin.sh" ]]
}

# Run plugin command
cbash_plugin_run() {
    local plugin_name="$1"
    shift
    
    if ! cbash_plugin_exists "$plugin_name"; then
        echo "Error: plugin '$plugin_name' not found" >&2
        return 1
    fi
    
    # Load plugin if not already loaded
    cbash_load_plugin "$plugin_name"
    
    # Try to execute plugin's main function or script
    local plugin_dir
    if [[ -d "$CBASH_DIR/custom/plugins/$plugin_name" ]]; then
        plugin_dir="$CBASH_DIR/custom/plugins/$plugin_name"
    else
        plugin_dir="$CBASH_DIR/plugins/$plugin_name"
    fi
    
    # Execute plugin script directly
    "$plugin_dir/$plugin_name.plugin.sh" "$@"
}

# List available plugins
cbash_list_plugins() {
    echo "Core Plugins:"
    local plugins
    plugins=$(find "$CBASH_DIR/plugins" -name "*.plugin.sh" 2>/dev/null | sort)
    for plugin in $plugins; do
        [[ -f "$plugin" ]] && basename "$(dirname "$plugin")"
    done
    
    echo ""
    echo "Custom Plugins:"
    if [[ -d "$CBASH_DIR/custom/plugins" ]]; then
        plugins=$(find "$CBASH_DIR/custom/plugins" -name "*.plugin.sh" 2>/dev/null | sort)
        for plugin in $plugins; do
            [[ -f "$plugin" ]] && basename "$(dirname "$plugin")"
        done
    fi
}
