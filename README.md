To make symlinks on windows open a cmd with admin rights move to your home and do

```batch
> mklink .vimrc dotfiles\.vimrc
```

To make symlinks on linux open a terminal in your home and do
```bash
$ ln -s dotfiles/.vimrc
```

At least on windows, if you execute a `git config --global` command, it breaks the links and converts your `~/.gitconfig` into an actual file.
