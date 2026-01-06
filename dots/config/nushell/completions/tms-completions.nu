module completions {
    # Configure the defaults for search paths and excluded directories
    export extern "tms config" [
        --paths(-p): list<path>   # The paths to search through. Shell like expansions such as '~' are supporte
        --sessions(-s): string    # The default session to switch to (if available) when killing another session
        --excluded: path          # As many directory names as desired to not be searched over
        --remove: path            # As many directory names to be removed from exclusion list
        --full-path               # Use the full path when displaying directories [possible values: true, false]
        --search-submodules       # Also show initialized submodules [possible values: true, false]
        --recursive-submodules    # Search submodules for submodules [possible values: true, false]
        --switch-filter-unknown   # Only include sessions from search paths in the switcher [possible values: true, false]
        --max-depths: int         # The maximum depth to traverse when searching for repositories in search paths, length should match the number of search paths if specified (defaults to 10)
        --picker-highlight-color: string  # Background color of the highlighted item in the picker [#rrggbb format]
        --picker-highlight-text-color: string # Text color of the hightlighted item in the picker [#rrggbb format]

        --picker-border-color: string # Color of the borders between widgets in the picker [#rrggbb format]
        --picker-info-color: string   # Color of the item count in the picker [#rrggbb format]
        --picker-prompt-color: string # Color of the prompt in the picker [#rrggbb format]
        --session-sort-order: string  # Set the sort order of the sessions in the switch command [possible values: Alphabetical, LastAttached]
        --clone-repo-switch: string   # Whether to automatically switch to the new session after the `clone-repo` command finishes [possible values: Always, Never, Foreground]
        --help(-h)                # Print help
    ]

    # List current config including all default values
    export extern "tms config list" [
        --defaults(-d)            # List only defaults without user set values
        --help(-h)                # Print help
    ]

    # Print this message or the help of the given subcommand(s)
    export extern "tms config help" []

    # Initialize tmux with the default session
    export extern "tms start" [
        --help(-h)                # Print help
    ]

    # Display other sessions with a fuzzy finder and a preview window
    export extern "tms switch" [
        --help(-h)                # Print help
    ]

    # Display the current session's windows with a fuzzy finder and a preview window
    export extern "tms windows" [
        --help(-h)                # Print help
    ]

    # Kill the current tmux session and jump to another
    export extern "tms kill" [
        --help(-h)                # Print help
    ]

    # Show running tmux sessions with asterisk on the current session
    export extern "tms sessions" [
        --help(-h)                # Print help
    ]

    # Rename the active session and the working directory
    export extern "tms rename" [
        --help(-h)                # Print help
        new_session_name: string  # The new session's name
    ]

    # Creates new worktree windows for the selected session
    export extern "tms refresh" [
        --help(-h)                # Print help
        session_name?: string     # The session's name. If not provided gets current session
    ]

    # Clone repository and create a new session for it
    export extern "tms clone-repo" [
        --help(-h)                # Print help
        git_repository: string    # Git repository to clone
    ]

    # Initialize empty repository
    export extern "tms init-repo" [
        --help(-h)                 # Print help
        git_repository: string     # Name of repository to initialize
    ]

    # Bookmark a directory so it is available to select along with the Git repositories
    export extern "tms bookmark" [
        --delete(-d)              # Delete instead of add a bookmark
        --help(-h)                # Print help
        path_to_bookmark?: path   # Path to bookmark, if left empty bookmark the current directory
    ]

    # Open a session
    export extern "tms open-session" [
        --help(-h)                # Print help
        session_name: string      # Name of the session to open
    ]

    # Manage list of sessions that can be instantly accessed by their index
    export extern "tms marks" [
        --help(-h)                # Print help
        index: int                # The index of the mark to open
    ]

    # List all marks
    export extern "tms marks list" [
        --help(-h)                # Print help
    ]

    # Add a session mark
    export extern "tms marks set" [
        --path(-p): path          # Path to project directory, if empty will use the current directory
        --help(-h)                # Print help
        index?: int               # Index of mark to set, if empty will append after the last item
    ]

    # Open the session at index
    export extern "tms marks open" [
        --help(-h)                # Print help
        index: int                # The index of the mark to open
    ]

    # Delete marks
    export extern "tms marks delete" [
        --all(-a)                 # Delete all items
        --help(-h)                # Print help
        index?:                   # Index of mark to delete
    ]

    # Print this message or the help of the given subcommand(s)
    export extern "tms marks help" []

    # Print this message or the help of the given subcommand(s)
    export extern "tms help" []
}

export use completions *
