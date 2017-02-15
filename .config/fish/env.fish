# Locale
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

# Editor
set -x EDITOR vim

# Golang
set -x GOPATH $HOME
set fish_user_paths $GOROOT/bin $fish_user_paths
set fish_user_paths $GOPATH/bin $fish_user_paths

# pyenv
set -x PYENV_ROOT /usr/local/var/pyenv
if status --is-interactive; and type -q pyenv
    . (pyenv init -|psub)
end

# Add $HOME/bin to PATH
set fish_user_paths $HOME/bin $fish_user_paths

# Themes
set -x theme_color_scheme 'terminal'

