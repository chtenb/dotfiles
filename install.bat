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
copy %UserProfile%\dotfiles\git_bash_here.ahk "%UserProfile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
del /q %UserProfile%\AppData\Roaming\nushell\config.nu
mklink %UserProfile%\AppData\Roaming\nushell\config.nu %UserProfile%\dotfiles\default_config.nu
pause
