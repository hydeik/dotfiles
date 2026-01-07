#
# config.nu -- Nushell configuration
#
#--------------------------------------
# Config
#--------------------------------------

# $env.config record settings
$env.config.show_banner = false
$env.config.edit_mode = "vi"
$env.config.cursor_shape = {
    emacs: "inherit"
    vi_insert: "line"
    vi_normal: "block"
}

# hooks
$env.config.hooks = ($env.config.hooks? | default {})
$env.config.hooks.env_change.PWD = (
    $env.config.hooks.env_change.PWD?
    | default []
    | append {||
        direnv export json
        | from json --strict
        | default {}
        | items {|key, value|
            let value = do (
                {
                    "PATH": {
                        from_string: {|s| $s | split row (char esep) | path expand --no-symlink }
                        to_string: {|v| $v | path expand --no-symlink | str join (char esep) }
                    }
                }
                | merge ($env.ENV_CONVERSIONS? | default {})
                | get ([[value, optional, insensitive]; [$key, true, true] [from_string, true, false]] | into cell-path)
                | if ($in | is-empty) { {|x| $x} } else { $in }
            ) $value
            return [ $key $value ]
        }
        | into record
        | load-env
    }
    | append (use nu-hooks/nu-hooks/startup-times.nu; startup-times)
    | append (
        use nu-hooks/nu-hooks/toolkit.nu;
        toolkit setup --name "tk" --color "yellow_bold"
    )
)

# Keybindings
$env.config.keybindings = ($env.config.keybindings? | default {})
$env.config.keybindings = (
    $env.config.keybindings
    | append {
        name: move_right_or_take_history_hint
        modifier: control
        keycode: char_f
        mode: [emacs, vi_insert]
        event: {
            until: [
                {send: historyhintcomplete}
                {send: menuright}
                {send: right}
            ]
        }
    }
)

# Theme
source ./themes/catppuccin_mocha.nu

# Prompt -> use starship
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""

# Custom completions
use ./completions/tms-completions.nu *
use ./completions/tv-completions.nu *
use custom-completions/uv/uv-completions.nu *
