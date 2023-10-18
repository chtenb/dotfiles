ln -sf ~/dotfiles/.bash_aliases ~/
ln -sf ~/dotfiles/.vimrc ~/
ln -sf ~/dotfiles/.vimrc.bare ~/
ln -sf ~/dotfiles/.taskrc ~/
ln -sf ~/dotfiles/.tmux.conf ~/
ln -sf ~/dotfiles/linux.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore
ln -sf ~/dotfiles/.jjconfig ~/.jjconfig

mkdir -p ~/.vim/backup/
mkdir -p ~/.vim/swap/
mkdir -p ~/.vim/undo/

echo 'perl ~/dotfiles/bin/replac.pl "$@"' > ~/.local/bin/replac
chmod +x ~/.local/bin/replac

ln -sf /usr/bin/batcat ~/.local/bin/bat
bat cache --build

ln -sf ~/dotfiles/config.nu ~/.config/nushell/config.nu
ln -sf ~/dotfiles/env.nu ~/.config/nushell/env.nu


ln -sfT ~/dotfiles/broot ~/.config/broot
ln -sfT ~/dotfiles/helix ~/.config/helix


echo "bat and delta must be installed manually using downloaded .deb files"
echo "nushell must be installed manually, e.g. using cargo install nu"
echo "install hx using apt (see website)"
echo "install broot by downloading from github adn placing it in ~/.local/bin"
echo "install ouch by installing from cargo"
echo "to fix delta colors run the nu command ansicol"

