mklink %APPDATA%\Code\User\settings.json %UserProfile%\dotfiles\settings.json
mklink %APPDATA%\Code\User\keybindings.json %UserProfile%\dotfiles\keybindings.json
del /q %UserProfile%\.ideavimrc
mklink %UserProfile%\.ideavimrc %UserProfile%\dotfiles\.ideavimrc
del /q %UserProfile%\_vsvimrc
mklink %UserProfile%\_vsvimrc %UserProfile%\dotfiles\_vsvimrc
del /q %UserProfile%\.vimrc
mklink %UserProfile%\.vimrc %UserProfile%\dotfiles\.vimrc
del /q %UserProfile%\.vimrc.bare
mklink %UserProfile%\.vimrc.bare %UserProfile%\dotfiles\.vimrc.bare
del /q %UserProfile%\.bash_aliases
mklink %UserProfile%\.bash_aliases %UserProfile%\dotfiles\.bash_aliases
del /q %UserProfile%\.bash_profile
mklink %UserProfile%\.bash_profile %UserProfile%\dotfiles\.bash_profile
del /q %UserProfile%\.bash_profile
mklink %UserProfile%\.bash_profile %UserProfile%\dotfiles\.bash_profile
del /q %UserProfile%\.bashrc
mklink %UserProfile%\.bashrc %UserProfile%\dotfiles\.bashrc
del /q %UserProfile%\.zshrc
mklink %UserProfile%\.zshrc %UserProfile%\dotfiles\.zshrc
del /q %UserProfile%\.gitconfig
mklink %UserProfile%\.gitconfig %UserProfile%\dotfiles\intellimagic.gitconfig
del /q %UserProfile%\.xcompose
mklink %UserProfile%\.xcompose %UserProfile%\dotfiles\.xcompose

REM copy %UserProfile%\dotfiles\git_bash_here.ahk "%UserProfile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

mkdir %UserProfile%\.vim\backup\
mkdir %UserProfile%\.vim\swap\
mkdir %UserProfile%\.vim\undo\

mkdir %UserProfile%\AppData\Roaming\nushell\
del /q %UserProfile%\AppData\Roaming\nushell\config.nu
mklink %UserProfile%\AppData\Roaming\nushell\config.nu %UserProfile%\dotfiles\config.nu
del /q %UserProfile%\AppData\Roaming\nushell\env.nu
mklink %UserProfile%\AppData\Roaming\nushell\env.nu %UserProfile%\dotfiles\env.nu

mkdir %UserProfile%\AppData\Roaming\elvish\
del /q %UserProfile%\AppData\Roaming\elvish\rc.elv
mklink %UserProfile%\AppData\Roaming\elvish\rc.elv %UserProfile%\dotfiles\rc.elv

mkdir %UserProfile%\.config
rmdir %UserProfile%\.config\wezterm
mklink /d %UserProfile%\.config\wezterm %UserProfile%\dotfiles\wezterm

mkdir %UserProfile%\AppData\Roaming\dystroy\broot
rmdir /s /q %UserProfile%\AppData\Roaming\dystroy\broot\config
mklink /d %UserProfile%\AppData\Roaming\dystroy\broot\config %UserProfile%\dotfiles\broot

rmdir /s /q %UserProfile%\AppData\Roaming\helix
mklink /d %UserProfile%\AppData\Roaming\helix %UserProfile%\dotfiles\helix

rmdir /s /q %UserProfile%\AppData\Roaming\yazi\config
rmdir /s /q %UserProfile%\AppData\Roaming\yazi
mkdir %UserProfile%\AppData\Roaming\yazi
mklink /d %UserProfile%\AppData\Roaming\yazi\config %UserProfile%\dotfiles\yazi

echo MANUALLY
echo install nu by running:
echo cargo install nu --features=extra
echo cargo install broot --features=clipboard
echo cargo install bat
echo cargo install git-delta

python neo-ansi/apps/bat/deploy-to-bat.py

del /q %UserProfile%\dotfiles\helix\themes\neo-ansi.toml
mklink %UserProfile%\dotfiles\helix\themes\neo-ansi.toml %UserProfile%\dotfiles\neo-ansi\apps\helix\neo-ansi.toml
del /q %UserProfile%\dotfiles\helix\themes\neo-ansi-syntax.toml
mklink %UserProfile%\dotfiles\helix\themes\neo-ansi-syntax.toml %UserProfile%\dotfiles\neo-ansi\apps\helix\neo-ansi-syntax.toml

del /q %UserProfile%\dotfiles\yazi\theme.toml
mklink %UserProfile%\dotfiles\yazi\theme.toml %UserProfile%\dotfiles\neo-ansi\apps\yazi\theme.toml

del /q %UserProfile%\dotfiles\broot\skins\neo-ansi.toml
mklink %UserProfile%\dotfiles\broot\skins\neo-ansi.toml %UserProfile%\dotfiles\neo-ansi\apps\broot\neo-ansi.toml

pause
