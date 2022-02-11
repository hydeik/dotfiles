# Dotfiles

My dotfiles managed by [chezmoi](https://github.com/twpayne/chezmoi).
The `chezmoi`'s documentation is available at [chezmoi.io](https://www.chezmoi.io).

## Bootstrapping

[Install chesmoi](https://www.chezmoi.io/quick-start/), then initialize chezmoi
with the dotfile repo:

```sh
$ chezmoi init https://github.com/hydeik/dotfiles
```

Run

```sh
$ chezmoi edit-config
```

and input the data necessary for filling templates, such as:

```toml
[data]
    name = "Your Name"
    email = "your@email.address"
```

Check the changes that chezmoi will be made in the home directory:

```sh
$ chezmoi diff # to check the changes that will be made
```

If it is OK, apply the changes:

```sh
$ chezmoi -v apply # apply
```
