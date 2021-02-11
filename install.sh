ln -sf ~/dotfiles/.bash_aliases ~/
ln -sf ~/dotfiles/.vimrc ~/
ln -sf ~/dotfiles/.vimrc.bare ~/
ln -sf ~/dotfiles/.tmux.conf ~/
ln -sf ~/dotfiles/.gitconfig-linux ~/.gitconfig
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore

mkdir ~/.vim/backup/
mkdir ~/.vim/swap/
mkdir ~/.vim/undo/

echo 'perl ~/dotfiles/bin/replac.pl "$@"' > ~/.local/bin/replac
chmod +x ~/.local/bin/replac
