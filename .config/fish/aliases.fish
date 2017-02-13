## cd
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'

## ls
alias ls 'ls -vaF'
# for typo
alias kls 'ls'
alias sls 'ls'

## mv
alias mv 'mv -i'

## cp
alias mv 'cp -i'

## less
# `les` for typo of `less`
function les
    less $argv
end

## ps
# show all processes
function psa
    ps auxw $argv
end
 
# show top 10 CPU consuming processes
function pst
    psa | head -n 1
    psa | sort -r -n -k 3 | grep -v "ps -auxww" | grep -v grep | head -n 10
end

# show top 10 memory consuming processes
function psm
    psa | head -n 1
    psa | sort -r -n -k 4 | grep -v "ps -auxww" | grep -v grep | head -n 10
end

# show processes matches to the arguments
function psg
    psa | head -n 1
    psa | grep $argv | grep -v "ps -auxww" | grep -v grep
end

## make a backup of files/directories
function bak
    for file in $argv
       if test -e $file.bak; or test -d $file.bak
           echo "$file.bak already exist"
       else
           command cp -ir $file $file.bak
       end
    end
end
