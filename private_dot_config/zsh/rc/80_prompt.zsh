##=====================================================================
## rc/80_prompt.zsh -- Customize command line prompts
##=====================================================================

# ## Spaceship
#
# SPACESHIP_PROMPT_ORDER=(
#     time          # Time stampts section
#     user          # Username section
#     host          # Hostname section
#     dir           # Current directory section
#     git           # Git section (git_branch + git_status)
#     hg            # Mercurial section (hg_branch  + hg_status)
#     node          # Node.js section
#     rust          # Rust section
#     venv          # virtualenv section
#     pyenv         # Pyenv section
#     exec_time     # Execution time
#     line_sep      # Line break
#     jobs          # Background jobs indicator
#     exit_code     # Exit code section
#     char          # Prompt character
# )
#
# SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
# SPACESHIP_CHAR_SYMBOL="\u279c "
#
# SPACESHIP_USER_SHOW=always
# SPACESHIP_USER_PREFIX="\uf007 "
#
# SPACESHIP_HOST_SHOW=always
# case "$OSTYPE" in
#     darwin*)  SPACESHIP_HOST_PREFIX="\uf179 " ;;
#     freebsd*) SPACESHIP_HOST_PREFIX="\uf30c " ;;
#     linux*)   SPACESHIP_HOST_PREFIX="\uf17c " ;;
#     *)        SPACESHIP_HOST_PREFIX="\uf17a " ;; # windows
# esac
#
# SPACESHIP_DIR_PREFIX="\uf115 "
#
# SPACESHIP_GIT_PREFIX="\uf1d2 "
# SPACESHIP_HG_PREFIX="(hg) "

# #
# # Starship --- The cross-shell prompt for astronauts
# #
# if (( ${+commands[starship]} )); then
#     eval "$(starship init zsh)"
# fi

# ----- End of zshrc -----
# vim: foldmethod=marker
