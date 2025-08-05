##======================================================================
## rc/30_options -- Set options [see also `man zshoptions`]
##======================================================================

## --- Changing directories
# {{{

# If a command is issued that can’t be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

# Make cd push the old directory onto the directory stack.
# (NOTE: Type `cd -[TAB]` to show the directory stack.)
setopt auto_pushd

# Don’t push multiple copies of the same directory onto the directory stack.
setopt pushd_ignore_dups

# Have `pushd` with no arguments act like `pushd $HOME`.
setopt pushd_to_home

# Do not print the directory stack after `pushed` or `popd`
#setopt pushd_silent

# }}}

## --- Completion
# {{{

# Move cursor to the end of a completed word.
setopt always_to_end

# Show completion menu on a successive tab press.
setopt auto_menu

# Automatically list choices on ambiguous completion.
setopt auto_list

# If completed parameter is a directory, add a trailing slash.
setopt auto_param_slash

# If completed parameter is a directory and input a word delimiter, remove the
# last slash.
setopt auto_remove_slash

# Complete from both ends of a word.
setopt complete_in_word

# Try to make the completion list smaller.
setopt list_packed

# When listing files that are possible completions, show the type of each file
# with a trailing identifying mark.
setopt list_types

# Do not autoselect the first completion entry.
unsetopt menu_complete

# }}}

## --- Expansion and Globbing
# {{{

# Make globbing insensitive to case.
unsetopt case_glob

# Perform =filename expansion
setopt equals

# Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename
# generation, etc.
setopt extended_glob

# Enable completion after = in command line arguments, e.g., "--prefix=~/dir".
# The main purpose of this option is complete after tilde.
setopt magic_equal_subst

# If numeric filenames are matched by a filename generation pattern, sort the
# filenames numerically rather than lexicographically.
setopt numeric_glob_sort

# }}}

## --- History
# {{{

# Save each command’s beginning timestamp (in seconds since the epoch) and the
# duration (in seconds) to the history file.
setopt extended_history

# When searching for history entries in the line editor, do not display
# duplicates of a line previously found, (even if the duplicates are not
# contiguous).
setopt hist_find_no_dups

# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list (even if it is not the
# previous event).
setopt hist_ignore_all_dups

# Do not enter command lines into the history list if they are duplicates of
# the previous event.
setopt hist_ignore_dups

# Remove command lines from the history list when the first character on the
# line is a space, or when one of the expanded aliases contains a leading
# space.
setopt hist_ignore_space

# Remove the function definitions from the history list.
setopt hist_no_functions

# Remove the `history` (`fc -l`) command from the history list when invoked.
setopt hist_no_store

# Remove superfluous blanks from each command line being added to the history
# list.
setopt hist_reduce_blanks

# When writing out the history file, older commands that duplicate newer ones are omitted.
setopt hist_save_no_dups

# Share history
setopt share_history

# }}}

## --- Input/Output
# {{{

# Try to correct the spelling of commands
setopt correct

# Disable output flow control via start/stop characters in the shell's editor
# (usually assigned to ^S/^Q).
unsetopt flow_control

# Do not exit on end-of-file (^D)
#setopt ignore_eof

# Allow comments even in interactive shells
setopt interactive_comments

# Perform path search even on command names with slashes.
setopt path_dirs

# Print eight bit characters literally in completion lists, etc.
setopt print_eight_bit

# Do not query the user before executing ‘rm *’ or ‘rm path/*’.
#setopt rm_star_silent

# If querying the user before executing ‘rm *’ or ‘rm path/*’, first wait ten
# seconds and ignore anything typed in that time.
setopt rm_star_wait

# }}}

## --- Job Control
# {{{

# If set, report the status of background and suspended jobs before exiting a
# shell with job control; a second attempt to exit the shell will succeed.
# NO_CHECK_JOBS is best used only in combination with NO_HUP, else such jobs
# will be killed automatically.
unsetopt check_jobs
# Don't send the HUP signal to running (background) jobs when the shell exits.
unsetopt hup

# }}}

## --- Zle
# {{{

# Do not beep on error in Zle
unsetopt beep

# }}}

# ----- End of file -----
# vim: foldmethod=marker
