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
