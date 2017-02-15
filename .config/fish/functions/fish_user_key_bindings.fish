function fish_user_key_bindings -d 'define my bindings'
    #
    # Rebind fzf functions
    #
    # Ctrl-t: fuzzy search for files
    # Ctrl-r: fuzzy search for history
    # Alt-x: does the reverse isearch and execute command immediately
    # Alt-d: cd into sub-directories (recursively searched)
    # Alt-D: cd into sub-directories, including hidden ones.
    #
    bind \ct '__fzf_find_file'
    bind \cr '__fzf_reverse_isearch'
    bind \ex '__fzf_find_and_execute'
    bind \ed '__fzf_cd'
    bind \eD '__fzf_cd_with_hidden'
  
    if bind -M insert >/dev/null ^/dev/null
        bind -M insert \cf '__fzf_find_file'
        bind -M insert \cr '__fzf_reverse_isearch'
        bind -M insert \ex '__fzf_find_and_execute'
        bind -M insert \ed '__fzf_cd'
        bind -M insert \eD '__fzf_cd_with_hidden'
    end

    #
    # Ctrl-g repository search by ghq (require fzf, peco or percol for the selector)
    #
    bind \cg __ghq_crtl_g
end
