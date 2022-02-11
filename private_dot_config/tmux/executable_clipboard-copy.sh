#!/usr/bin/env bash
#
# Copy data to clipboard from stdin.
#

set -eu

has_command() {
    command -v "$1" >/dev/null 2>&1
}

buf=$(cat "$@")

# Copy with the 'pbcopy/xsel/xclip' command
backend=""
if has_command pbcopy; then
    if has_command "reattach-to-user-namespace"; then
        backend="reattach-to-user-namespace pbcopy"
    else
        backend="pbcopy"
    fi
elif [ -n "${DISPLAY:-}" ] && has_command xsel; then
    backend="xsel -i --clipboard"
elif [ -n "${DISPLAY:-}" ] && has_command xclip; then
    backend="xclip -i -f -selection primary | xclip -i -selection clipboard"
fi

if [ -n "$backend" ]; then
    printf "%s" "$buf" | eval "$backend"
    exit;
fi

# Copy with OSC 52 escape sequences
buflen=$( printf "%s" "$@" | wc -c )
# https://sunaku.github.io/tmux-yank-osc52.html
# The maximum length of an OSC 52 escape sequence is 100_000 bytes, of which
# 7 bytes are occupied by a "\033]52;c;" header, 1 byte by a "\a" footer, and
# 99_992 bytes by the base64-encoded result of 74_994 bytes of copyable text
max_buflen=74994
if [ "$buflen" -gt "$max_buflen" ]; then
    printf "input is %d bytes too long" "$(( buflen - max_buflen ))" >&2
fi

# If we are on remote machine, send directly to SSH_TTY to transport escape
# sequence to terminal on local machine, so data lands in clipboard on our
# local machine
pane_active_tty=$(tmux list-panes -F "#{pane_active} #{pane_tty}" | awk '$1=="1" { print $2 }')
target_tty="${SSH_TTY:-$pane_active_tty}"

message=$(printf %s "$@" | haed -c $maxlen | base64 | tr -d '\r\n')
printf "\x1bPtmux;\x1b\x1b]52;c;%s\a\x1b\\" "message" > "$target_tty"
