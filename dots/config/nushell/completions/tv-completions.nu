module completions {
    def "nu-complete tv available_channels" [] {
        let channels = try {
            tv list-channels | lines
        } catch {[]}
        $channels
    }

    def "nu-complete tv border_choices" [] {
        [ "none" "plain" "rounded" "thick" ]
    }
    def "nu-complete tv available_layouts" [] {
        [ "landscape" "portrait" ]
    }

    # A very fast, portable and hackable fuzzy finder for the terminal
    export extern "tv" [
        channel?: string@"nu-complete tv available_channels"    # Which channel shall we watch?
        path?: path             # The working directory to start the application in
        --help(-h)              # Print help (see a summary with '-h')
        --version(-V)           # Print version
        --source-command(-s): string    # Source command to use for the current channel.
        --ansi                          # Whether tv should extract and parse ANSI style codes from the source command output.
        --source-display: string        # Source display template to use for the current channel.
        --source-output: string         # Source output template to use for the current channel.
        --source-entry-delimiter: string    # The delimiter byte to use for splitting the source's command output into entries.
        --preview-command(-p): string   # Preview command to use for the current channel.
        --preview-header: string        # Preview header template
        --preview-footer: string        # Preview footer template
        --cache-preview                 # Whether to cache the preview command output for each entry.
        --preview-offset: string        # A preview line number offset template to use to scroll the preview to for each entry.
        --no-preview                    # Disable the preview panel entirely on startup.
        --hide-preview                  # Hide the preview panel on startup (only works if feature is enabled).
        --show-preview                  # Show the preview panel on startup (only works if feature is enabled).
        --preview-border: string@"nu-complete tv border_choices"    #Sets the preview panel border type. [possible values: none, plain, rounded, thick]
        --preview-padding: string       # Sets the preview panel padding. [Format: `top=INTEGER;left=INTEGER;bottom=INTEGER;right=INTEGER`]
        --hide-preview-scrollbar        # Hide preview panel scrollbar.
        --preview-size: int             # Percentage of the screen to allocate to the preview panel (1-99).
        --input(-i): string             # Input text to pass to the channel to prefill the prompt.
        --input-header: string          # Input field header template.
        --input-prompt: string          # Input prompt string
        --input-border: string@"nu-complete tv border_choices"  # Sets the input panel border type. [possible values: none, plain, rounded, thick]
        --input-padding: string         # Sets the input panel padding. [Format: `top=INTEGER;left=INTEGER;bottom=INTEGER;right=INTEGER`]
        --no-status-bar                 # Disable the status bar entirely on startup.
        --hide-status-bar               # Hide the status bar on startup (only works if feature is enabled).
        --show-status-bar               # Show the status bar on startup (only works if feature is enabled).
        --results-border: string@"nu-complete tv border_choices"  # Sets the results panel border type. [possible values: none, plain, rounded, thick]
        --results-padding: string       # Sets the results panel padding.
        --layout: string@"nu-complete tv available_layouts" # Layout orientation for the UI. [possible values: landscape, portrait]
        --no-remote                     # Disable the remote control.
        --hide-remote                   # Hide the remote control on startup (only works if feature is enabled).
        --show-remote                   # Show the remote control on startup (only works if feature is enabled).
        --no-help-panel                 # Disable the help panel entirely on startup.
        --hide-help-panel               # Hide the help panel on startup (only works if feature is enabled).
        --show-help-panel               # Show the help panel on startup (only works if feature is enabled).
        --ui-scale: int                 # Change the display size in relation to the available area.
        --height: int                   # Height in lines for non-fullscreen mode.
        --width: int                    # Width in columns for non-fullscreen mode.
        --inline                        # Use all available empty space at the bottom of the terminal as an inline interface.
        --tick-rate(-t)                 # The application's tick rate
        --watch: float                  # Watch mode: reload the source command every N seconds.
        --autocomplete-prompt: string   # Try to guess the channel from the provided input prompt.
        --exact                         # Use substring matching instead of fuzzy matching.
        --select-1                      # Automatically select and output the first entry if there is only one entry.
        --take-1                        # Take the first entry from the list after the channel has finished loading.
        --take-1-fast                   # Take the first entry from the list as soon as it becomes available.
        --keybindings(-k): string       # Keybindings to override the default keybindings.
        --expect: string                # Keys that can be used to confirm the current selection in addition to the default ones (typically `enter`).
        --config-file: path             # Provide a custom configuration file to use.
        --cable-dir: path               # Provide a custom cable directory to use.
        --global-history                # Use global history instead of channel-specific history
    ]

    # List the available channels
    export extern "tv list-channels" [
        --help(-h)              # Print help
    ]

    def "nu-complete tv supported_shells" [] {
        [ "bash" "zsh" "fish" "power-shell" "cmd" "nu" ]
    }

    # Initializes shell completion ("tv init zsh")
    export extern "tv init" [
        shell: string@"nu-complete tv supported_shells" # The shell for which to generate the autocompletion script [possible values: bash, zsh, fish, power-shell, cmd, nu]
        --help(-h)              # Print help
    ]

    # Downloads the latest collection of channel prototypes from github and saves them to the local configuration directory
    export extern "tv update-channels" [
        --force                 # Force update on already existing channels
        --help(-h)              # Print help
    ]

    # Print this message or the help of the given subcommand(s)
    export extern "tv help" []
}

export use completions *
