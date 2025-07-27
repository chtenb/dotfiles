ln -sf ~/prj/dotfiles/.bash_profile ~/
ln -sf ~/prj/dotfiles/.bash_aliases ~/
ln -sf ~/prj/dotfiles/.zshrc ~/
ln -sf ~/prj/dotfiles/.vimrc ~/
ln -sf ~/prj/dotfiles/.vimrc.bare ~/
ln -sf ~/prj/dotfiles/.taskrc ~/
ln -sf ~/prj/dotfiles/.tmux.conf ~/
ln -sf ~/prj/dotfiles/linux.gitconfig ~/.gitconfig
ln -sf ~/prj/dotfiles/.gitignore_global ~/.gitignore
ln -sf ~/prj/dotfiles/.jjconfig ~/.jjconfig

mkdir -p ~/.vim/backup/
mkdir -p ~/.vim/swap/
mkdir -p ~/.vim/undo/

mkdir -p ~/.local/bin

echo 'perl ~/prj/dotfiles/bin/replac.pl "$@"' > ~/.local/bin/replac
chmod +x ~/.local/bin/replac

echo "bat must be installed manually, e.g. using cargo install bat"
echo Then manually run neo-ansi/apps/bat/deploy-to-bat.py

ln -sf /usr/bin/batcat ~/.local/bin/bat
bat cache --build

mkdir -p ~/.config/nushell

ln -sf ~/prj/dotfiles/config.nu ~/.config/nushell/config.nu
ln -sf ~/prj/dotfiles/env.nu ~/.config/nushell/env.nu


ln -sfT ~/prj/dotfiles/broot ~/.config/broot
ln -sfT ~/prj/dotfiles/helix ~/.config/helix
ln -sfT ~/prj/dotfiles/yazi ~/.config/yazi


rm -f ~/prj/dotfiles/helix/themes/neo-ansi.toml
ln -s ~/prj/dotfiles/neo-ansi/apps/helix/neo-ansi.toml ~/prj/dotfiles/helix/themes/neo-ansi.toml
rm -f ~/prj/dotfiles/helix/themes/neo-ansi-syntax.toml
ln -s ~/prj/dotfiles/neo-ansi/apps/helix/neo-ansi-syntax.toml ~/prj/dotfiles/helix/themes/neo-ansi-syntax.toml
rm -f ~/prj/dotfiles/broot/skins/neo-ansi.toml
ln -s ~/prj/dotfiles/neo-ansi/apps/broot/neo-ansi.toml ~/prj/dotfiles/broot/skins/neo-ansi.toml
rm -f ~/prj/dotfiles/yazi/theme.toml
ln -s ~/prj/dotfiles/neo-ansi/apps/yazi/theme.toml ~/prj/dotfiles/yazi/theme.toml


echo "nushell must be installed manually, e.g. using cargo install nu"
echo "broot must be installed manually, e.g. using cargo install broot"
echo "git-delta must be installed manually, e.g. using cargo install git-delta"
