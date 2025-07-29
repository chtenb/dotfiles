set shell := ["sh", "-cu"]
is-windows := `uname -s | grep -qi 'mingw\|msys' && echo true || echo false`

update-zsh:
	@echo "Updating Git repos in zsh/..."
	@for repo in zsh/*; do \
		echo "Updating $repo"; \
		git -C "$repo" fetch origin master; \
		git -C "$repo" checkout master; \
	done    
	zsh -c 'autoload -Uz compinit; compinit'
