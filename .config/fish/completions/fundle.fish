function __fish_fundle_needs_command
    set cmd (commandline -opc)
    if [ (count $cmd) -eq 1 -a $cmd[1] = 'fundle' ]
        return 0
    end
    return 1
end

function __fish_fundle_using_command
    set cmd (commandline -opc)
    if [ (count $cmd) -gt 1 ]
        if [ $argv[1] = $cmd[2] ]
            return 0
        end
    end
    return 1
end

complete -f -c fundle -n '__fish_fundle_needs_command' -a init -d "load all plugins"
complete -f -c fundle -n '__fish_fundle_needs_command' -a plugin -d "add a plugin"
complete -f -c fundle -n '__fish_fundle_needs_command' -a list -d "list plugins"
complete -f -c fundle -n '__fish_fundle_needs_command' -a install -d "install all plugins"
complete -f -c fundle -n '__fish_fundle_needs_command' -a update -d "update existing plugins"
complete -f -c fundle -n '__fish_fundle_needs_command' -a clean -d "cleans unused plugins"
complete -f -c fundle -n '__fish_fundle_needs_command' -a self-update -d "update fundle"
complete -f -c fundle -n '__fish_fundle_needs_command' -a version -d "display fundle version"
complete -f -c fundle -n '__fish_fundle_needs_command' -a help -d "display helps"

complete -f -c fundle -n '__fish_fundle_using_command install' -s u -l update -d "update existing plugins (deprecated)"

complete -f -c fundle -n '__fish_fundle_using_command list' -s s -l short -d "show a short list with plugin names only"

complete -f -c fundle -n '__fish_fundle_using_command init' -s p -l profile -d "profile time for loading each plugin"

complete -f -c fundle -n '__fish_fundle_using_command plugin' -l url -d "set the plugin URL"
complete -f -c fundle -n '__fish_fundle_using_command plugin' -l path -d "set the plugin load path"
