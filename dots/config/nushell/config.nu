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
    | append (use nu-hooks/nu-hooks/startup-times.nu; startup-times setup)
    | append (
        use nu-hooks/nu-hooks/toolkit.nu;
        toolkit setup --name "tk" --color "yellow_bold"
    )
)


# $env.config.hooks = {
#     env_change: {
#         PWD: [
#             (use nu-hooks/nu-hooks/startup-times.nu; startup-times setup)
#             # (
#             #     use nu-hooks/nu-hooks/tookkit.nu
#             #     toolkit setup --name "tk" --color "yellow_bold"
#             # )
#         ]
#     }
# }

