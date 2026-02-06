#
# env.nu -- Nushell environment variables
#

export-env {
    let esep_list_converter =  {
        from_string: {|s| $s | split row (char esep) | path expand --no-symlink }
        to_string: {|v| $v |  path expand --no-symlink | str join (char esep) }
    }

    let space_list_converter =  {
        from_string: {|s| $s | split row (char space) | path expand --no-symlink }
        to_string: {|v| $v | path expand --no-symlink | str join (char space) }
    }

    $env.ENV_CONVERSIONS = {
        XDG_CONFIG_DIRS: $esep_list_converter
        XDG_DATA_DIRS: $esep_list_converter
        TERMINFO_DIRS: $esep_list_converter
        NIX_PROFILES: $space_list_converter
        "MANPATH": {
            from_string : {|s| $s | split row (char esep) | path expand --no-symlink }
            # NOTE: MANPATH needs a trailing colon to work
            to_string   : {|v| $v | path expand --no-symlink | str join (char esep) | $"($in):" }
        }
    }
}

export-env {
    # XDG base directory
    $env.XDG_CACHE_HOME = $env.XDG_CACHE_HOME? | default ($nu.home-dir | path join ".cache")
    $env.XDG_CONFIG_HOME = $env.XDG_CONFIG_HOME? | default ($nu.home-dir | path join ".config")
    $env.XDG_DATA_HOME = $env.XDG_DATA_HOME? | default ($nu.home-dir | path join ".local" "share")
    $env.XDG_STATE_HOME = $env.XDG_STATE_HOME? | default ($nu.home-dir | path join ".local" "state")
    # nupm -- nushell package manager
    $env.NUPM_CACHE = ($env.XDG_CACHE_HOME | path join "nupm")
    $env.NUPM_HOME = ($env.XDG_DATA_HOME | path join "nupm")
}

# PATH
use std "path add"
path add "/usr/texbin"

if ($nu.os-info.name == "macos") {
    if ($nu.os-info.arch == "aarch64") {
        path add "/opt/homebrew/bin"
    }
} else if ($nu.os-info.name == "linux") {
    path add ($nu.home-dir | path join ".linuxbrew" "bin")
}

$env.NIX_PROFILES | each {|e|
    path add ($e | path join "bin")
}
path add ($env.CARGO_HOME | path join "bin")
path add ($env.NUPM_HOME | path join "bin")
path add ($env.XDG_BIN_HOME? | default ($env.HOME | path join ".local" "bin"))
$env.PATH = $env.PATH | uniq | where {|e| $e | path exists }

# LD_LIBRARY_PATH
$env.LD_LIBRARY_PATH = (
    $env.LD_LIBRARY_PATH?
    | default ""
    | split row (char esep)
    | prepend "/usr/local/lib"
    | prepend ($env.XDG_LIB_HOME? | default ($env.HOME | path join ".local" "lib"))
    | uniq
    | where {|e| $e | path exists }
)

# nushell library/plugin dirs
$env.NU_LIB_DIRS = [
    ($env.NUPM_HOME | path join "modules")
    ($nu.default-config-dir | path join "modules")
    ($env.HOME | path join ".nix-profile" "share" "nushell")
    ($env.HOME | path join ".nix-profile" "share" "nu_scripts")
    $"/etc/profiles/per-user/($env.USER)/share/nu_scripts"
] | where {|e| $e | path exists }

$env.NU_PLUGIN_DIRS = [
    ($env.CARGO_HOME | path join "bin")
    ($env.NUPM_HOME | path join "plugins" "bin")
]

# Misc envs
$env.EDITOR = "nvim"
$env.VISUAL = $env.EDITOR
$env.SHELL = $nu.current-exe
$env.GPG_TTY = (tty)

