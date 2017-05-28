# Locale
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

# Editor
set -x EDITOR vim

# Golang
set -x GOPATH $HOME
set fish_user_paths $GOROOT/bin $fish_user_paths

# pyenv
set -x PYENV_ROOT $HOME/.pyenv
# if status --is-interactive; and type -q pyenv
#     . (pyenv init -|psub)
# end

# conda
if status --is-interactive; and type -q conda
    # (conda info --root) is so slow, so I do not use this
    #  . (conda info --root)/etc/fish/conf.d/conda.fish
    set CONDA_ROOT $HOME/.pyenv/versions/miniconda3-latest
     . $CONDA_ROOT/etc/fish/conf.d/conda.fish
end

# Add $HOME/bin to PATH
set fish_user_paths $HOME/bin $fish_user_paths

# Themes
set -x theme_color_scheme 'terminal'

#
# Intel C/C++, Intel Fortran, and MKL
#
set -l INTEL_COMPILER_DIR /opt/intel/compilers_and_libraries
set -l INTEL_COMPILER_ARCH intel64
set -l INTEL_COMPILERVARS_FILE $INTEL_COMPILER_DIR/linux/bin/compilervars.sh
if test -e $INTEL_COMPILERVARS_FILE
    bass source $INTEL_COMPILERVARS_FILE $INTEL_COMPILER_ARCH
end

