mklink %APPDATA%\Code\User\settings.json %UserProfile%\prj\dotfiles\settings.json
mklink %APPDATA%\Code\User\keybindings.json %UserProfile%\prj\dotfiles\keybindings.json
del /q %UserProfile%\.ideavimrc
mklink %UserProfile%\.ideavimrc %UserProfile%\prj\dotfiles\.ideavimrc
del /q %UserProfile%\_vsvimrc
mklink %UserProfile%\_vsvimrc %UserProfile%\prj\dotfiles\_vsvimrc
del /q %UserProfile%\.vimrc
mklink %UserProfile%\.vimrc %UserProfile%\prj\dotfiles\.vimrc
del /q %UserProfile%\.vimrc.bare
mklink %UserProfile%\.vimrc.bare %UserProfile%\prj\dotfiles\.vimrc.bare
del /q %UserProfile%\.bash_aliases
mklink %UserProfile%\.bash_aliases %UserProfile%\prj\dotfiles\.bash_aliases
del /q %UserProfile%\.bash_profile
mklink %UserProfile%\.bash_profile %UserProfile%\prj\dotfiles\.bash_profile
del /q %UserProfile%\.bash_profile
mklink %UserProfile%\.bash_profile %UserProfile%\prj\dotfiles\.bash_profile
del /q %UserProfile%\.bashrc
mklink %UserProfile%\.bashrc %UserProfile%\prj\dotfiles\.bashrc
del /q %UserProfile%\.zshrc
mklink %UserProfile%\.zshrc %UserProfile%\prj\dotfiles\.zshrc
del /q %UserProfile%\.gitconfig
mklink %UserProfile%\.gitconfig %UserProfile%\prj\dotfiles\intellimagic.gitconfig
del /q %UserProfile%\.xcompose
mklink %UserProfile%\.xcompose %UserProfile%\prj\dotfiles\.xcompose

REM copy %UserProfile%\prj\dotfiles\git_bash_here.ahk "%UserProfile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

mkdir %UserProfile%\.vim\backup\
mkdir %UserProfile%\.vim\swap\
mkdir %UserProfile%\.vim\undo\

mkdir %UserProfile%\AppData\Roaming\nushell\
del /q %UserProfile%\AppData\Roaming\nushell\config.nu
mklink %UserProfile%\AppData\Roaming\nushell\config.nu %UserProfile%\prj\dotfiles\config.nu
del /q %UserProfile%\AppData\Roaming\nushell\env.nu
mklink %UserProfile%\AppData\Roaming\nushell\env.nu %UserProfile%\prj\dotfiles\env.nu

mkdir %UserProfile%\AppData\Roaming\elvish\
del /q %UserProfile%\AppData\Roaming\elvish\rc.elv
mklink %UserProfile%\AppData\Roaming\elvish\rc.elv %UserProfile%\prj\dotfiles\rc.elv

mkdir %UserProfile%\.config
rmdir %UserProfile%\.config\wezterm
mklink /d %UserProfile%\.config\wezterm %UserProfile%\prj\dotfiles\wezterm

mkdir %UserProfile%\AppData\Roaming\dystroy\broot
rmdir /s /q %UserProfile%\AppData\Roaming\dystroy\broot\config
mklink /d %UserProfile%\AppData\Roaming\dystroy\broot\config %UserProfile%\prj\dotfiles\broot

rmdir /s /q %UserProfile%\AppData\Roaming\helix
mklink /d %UserProfile%\AppData\Roaming\helix %UserProfile%\prj\dotfiles\helix

rmdir /s /q %UserProfile%\AppData\Roaming\yazi\config
rmdir /s /q %UserProfile%\AppData\Roaming\yazi
mkdir %UserProfile%\AppData\Roaming\yazi
mklink /d %UserProfile%\AppData\Roaming\yazi\config %UserProfile%\prj\dotfiles\yazi

echo MANUALLY
echo install nu by running:
echo cargo install nu --features=extra
echo cargo install broot --features=clipboard
echo cargo install bat
echo cargo install git-delta

python neo-ansi/apps/bat/deploy-to-bat.py

del /q %UserProfile%\prj\dotfiles\helix\themes\neo-ansi.toml
mklink %UserProfile%\prj\dotfiles\helix\themes\neo-ansi.toml %UserProfile%\prj\dotfiles\neo-ansi\apps\helix\neo-ansi.toml
del /q %UserProfile%\prj\dotfiles\helix\themes\neo-ansi-syntax.toml
mklink %UserProfile%\prj\dotfiles\helix\themes\neo-ansi-syntax.toml %UserProfile%\prj\dotfiles\neo-ansi\apps\helix\neo-ansi-syntax.toml

del /q %UserProfile%\prj\dotfiles\yazi\theme.toml
mklink %UserProfile%\prj\dotfiles\yazi\theme.toml %UserProfile%\prj\dotfiles\neo-ansi\apps\yazi\theme.toml

del /q %UserProfile%\prj\dotfiles\broot\skins\neo-ansi.toml
mklink %UserProfile%\prj\dotfiles\broot\skins\neo-ansi.toml %UserProfile%\prj\dotfiles\neo-ansi\apps\broot\neo-ansi.toml

pause
