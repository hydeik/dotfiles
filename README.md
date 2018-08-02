# Dotfiles

Dotfiles managed by [Dotbot](https://github.com/anishathalye/dotbot). 
We refer [More adavanced setup](https://github.com/anishathalye/dotbot/wiki/Tips-and-Tricks)
section in Dotbot Wiki pages for the detailed setup.


## Installation

```
$ git clone --recursive https://github.com/hydeik/dotfiles /path/to/dotfiles
```

For installing predefined profile:

```
$ cd /path/to/dotfiles
$ ./install-profile <profile> [<configs...>]
$ # for example:
$ ./install-profile macosx
```

For installing single configuration:

```
$ cd /path/to/dotfiles
$ ./install-standalone <configs...>
$ # for example:
$ ./install-profile zsh vim tmux
```


