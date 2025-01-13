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

mkdir -p ~/.local/bin

echo 'perl ~/dotfiles/bin/replac.pl "$@"' > ~/.local/bin/replac
chmod +x ~/.local/bin/replac

echo "bat must be installed manually, e.g. using cargo install bat"
echo Then manually run neo-ansi/apps/bat/deploy-to-bat.py

ln -sf /usr/bin/batcat ~/.local/bin/bat
bat cache --build

mkdir -p ~/.config/nushell

ln -sf ~/dotfiles/config.nu ~/.config/nushell/config.nu
ln -sf ~/dotfiles/env.nu ~/.config/nushell/env.nu


ln -sfT ~/dotfiles/broot ~/.config/broot
ln -sfT ~/dotfiles/helix ~/.config/helix
ln -sfT ~/dotfiles/yazi ~/.config/yazi


rm -f ~/dotfiles/helix/themes/neo-ansi.toml
ln -s ~/dotfiles/neo-ansi/apps/helix/neo-ansi.toml ~/dotfiles/helix/themes/neo-ansi.toml
rm -f ~/dotfiles/helix/themes/neo-ansi-syntax.toml
ln -s ~/dotfiles/neo-ansi/apps/helix/neo-ansi-syntax.toml ~/dotfiles/helix/themes/neo-ansi-syntax.toml
rm -f ~/dotfiles/broot/skins/neo-ansi.toml
ln -s ~/dotfiles/neo-ansi/apps/broot/neo-ansi.toml ~/dotfiles/broot/skins/neo-ansi.toml
rm -f ~/dotfiles/yazi/theme.toml
ln -s ~/dotfiles/neo-ansi/apps/yazi/neo-ansi.toml ~/dotfiles/yazi/theme.toml


echo "nushell must be installed manually, e.g. using cargo install nu"
echo "broot must be installed manually, e.g. using cargo install broot"
echo "git-delta must be installed manually, e.g. using cargo install git-delta"
