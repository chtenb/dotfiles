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
del /q %UserProfile%\.bashrc
mklink %UserProfile%\.bashrc %UserProfile%\dotfiles\.bashrc
del /q %UserProfile%\.gitconfig
mklink %UserProfile%\.gitconfig %UserProfile%\dotfiles\intellimagic.gitconfig
del /q %UserProfile%\.XCompose
mklink %UserProfile%\.XCompose %UserProfile%\dotfiles\.XCompose

copy %UserProfile%\dotfiles\git_bash_here.ahk "%UserProfile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

mkdir %UserProfile%\.vim\backup\
mkdir %UserProfile%\.vim\swap\
mkdir %UserProfile%\.vim\undo\

mkdir %UserProfile%\AppData\Roaming\nushell\
del /q %UserProfile%\AppData\Roaming\nushell\config.nu
mklink %UserProfile%\AppData\Roaming\nushell\config.nu %UserProfile%\dotfiles\config.nu
del /q %UserProfile%\AppData\Roaming\nushell\env.nu
mklink %UserProfile%\AppData\Roaming\nushell\env.nu %UserProfile%\dotfiles\env.nu
del /q %UserProfile%\.wezterm.lua
mklink %UserProfile%\.wezterm.lua %UserProfile%\dotfiles\wezterm.lua

rmdir /s /q %UserProfile%\AppData\Roaming\dystroy\broot\config
mklink /d %UserProfile%\AppData\Roaming\dystroy\broot\config %UserProfile%\dotfiles\broot

rmdir /s /q %UserProfile%\AppData\Roaming\helix
mklink /d %UserProfile%\AppData\Roaming\helix %UserProfile%\dotfiles\helix

echo MANUALLY
echo install nu by running:
echo cargo install nu --features=extra
REM echo winget install nushell, or place it in .local
echo bat and git-delta must be installed manually using cargo
echo Then manually run bat cache --build and the command ansicol
echo Install helix and broot from the github releases by placing it in .local
pause
