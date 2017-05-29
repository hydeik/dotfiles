# Environment variables
source ~/.config/fish/env.fish

# Aliases
if status --is-interactive
    source ~/.config/fish/aliases.fish
end

# SSH keychain
if status --is-login
   if type -q keychain
       keychain --nogui --quiet ~/.ssh/id_ecdsa ~/.ssh/id_github_ecdsa
       source ~/.keychain/(hostname)-fish 
   end
end

function tmux_automatically_attach_session
    if test -n "$TMUX"
        echo 'Tmux already running'
    else if test -n "$STY"
        echo 'This is on screen'
    else
        if status --is-interactive; and test -z $SSH_CONNECTION
            type -q tmux
            if test $status -eq 1
                echo "Error: tmux commend not found" ^&1
                return 1
            end
        end

        if tmux has-session >/dev/null ^&1; and tmux list-sessions | grep -qE ".*]\$"
            tmux list-sessions
            read -p'echo -n "Tmux: attach? (y/N/num) "' reply
            if test -z '$reply'; or string match -r "^[yY]\$" "$reply"
                tmux attach-session
                if test $status -eq 0
                    echo (tmux -V) " attached session"
                    return 0
                end
            else if string match -r "^[0-9]+\$"
                tmux attach -t "$reply"
                if test $status -eq 0
                    echo (tmux -V) " attached session"
                    return 0
                end
            end
        else
            tmux new-session; and echo "tmux created a new session"
        end
    end
end

if status --is-interactive
    tmux_automatically_attach_session
end
