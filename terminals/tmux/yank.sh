#!/usr/bin/env bash

set -eu

command_exists() {
    command -v "$1" > /dev/null 1>&2
}

get_copy_backend() {
    local backend=""
    # Mac OSX
    if command_exists pbcopy; then
        if command_exists "reattach-to-user-namespace"; then
            backend="reattach-to-user-namespace pbcopy"
        else
            backend="pbcopy"
        fi
    # Linux X11
    elif [ -n "${DISPLAY:-}" ] && command_exists xsel; then
        backend="xsel -i --clipboard"
    elif [ -n "${DISPLAY:-}" ] && command_exists xclip; then
        backend="xclip -i -f -selection primary | xclip -i -selection clipboard"
    fi

    echo "$backend"
}

copy_via_osc52_esc() {
    local buflen
    buflen=$( printf "%s" "$@" | wc -c )
    # https://sunaku.github.io/tmux-yank-osc52.html
    # The maximum length of an OSC 52 escape sequence is 100_000 bytes, of which
    # 7 bytes are occupied by a "\033]52;c;" header, 1 byte by a "\a" footer, and
    # 99_992 bytes by the base64-encoded result of 74_994 bytes of copyable text
    local maxlen=74994
    if [ "$buflen" -gt "$maxlen" ]; then
        printf "input is %d bytes too long" "$(( buflen - maxlen ))" >&2
    fi

    # resolve target terminal to send escape sequence
    # if we are on remote machine, send directly to SSH_TTY to transport escape sequence
    # to terminal on local machine, so data lands in clipboard on our local machine
    pane_active_tty=$(tmux list-panes -F "#{pane_active} #{pane_tty}" | awk '$1=="1" { print $2 }')
    target_tty="${SSH_TTY:-$pane_active_tty}"

    printf "%s" "$esc" > "$target_tty"
}

main() {
    buf=$(cat "$@")
    copy_backend=$(get_copy_backend)

    if [ -n "$copy_backend" ]; then
        printf "%s" "$buf" | eval "$copy_backend"
        exit;
    fi
}

main "$@"
