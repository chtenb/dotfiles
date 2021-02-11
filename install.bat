mklink %APPDATA%\Code\User\settings.json %UserProfile%\dotfiles\settings.json
mklink %APPDATA%\Code\User\keybindings.json %UserProfile%\dotfiles\keybindings.json
mklink %UserProfile%\_vsvimrc %UserProfile%\dotfiles\_vsvimrc
mklink %UserProfile%\.vimrc %UserProfile%\dotfiles\.vimrc
mklink %UserProfile%\.vscvimrc %UserProfile%\dotfiles\.vscvimrc
mklink %UserProfile%\.vimrc.bare %UserProfile%\dotfiles\.vimrc.bare
mklink %UserProfile%\.bash_aliases %UserProfile%\dotfiles\.bash_aliases
mklink %UserProfile%\.bash_profile %UserProfile%\dotfiles\.bash_profile
mklink %UserProfile%\.gitconfig %UserProfile%\dotfiles\.gitconfig-intellimagic
copy %UserProfile%\dotfiles\git_bash_here.ahk "%UserProfile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
pause
