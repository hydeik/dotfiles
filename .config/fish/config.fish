# fundle -- plugin manager
fundle plugin 'edc/bass'
fundle plugin 'decors/fish-ghq'
fundle plugin 'd42/fish-pip-completion'
fundle plugin 'fisherman/fzf'
fundle plugin 'fisherman/termcolours'
fundle plugin 'oh-my-fish/theme-bobthefish'
#fundle plugin 'nesl247/fish-theme-dracula'

fundle init

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
