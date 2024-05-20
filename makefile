default:
	@echo "deps, zsh, links"

deps:
	@echo "Installing Dependencies"
	@brew update
	@brew install curl
	@brew install git
	@brew install bison
	@brew install zsh
	@brew install silversearcher-ag
	@brew install aria2
	@brew install htop
	@curl -fsSL https://starship.rs/install.sh | bash
	@curl "https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy" > /usr/bin/diff-so-fancy
	@sudo chmod +x /usr/bin/diff-so-fancy
	@brew install fzf

zsh:
	@echo "ZSH"
	@brew install zsh zsh-completions
	@if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then \
		echo "zsh autosuggestions"; \
		git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions; \
	fi
	@cd ~/.oh-my-zsh/themes && curl https://gist.githubusercontent.com/rafaelrubbioli/e2f65c243865a06adfce59e7545c9291/raw/d1aea9589590acd909f6f0d20a6837261d79d403/kuaty.zsh-theme > kuaty.zsh-theme

links:
	@ln -sf ${PWD}/.zshrc ~/.zshrc
	@ln -sf ${PWD}/.gitconfig ~/.gitconfig
	@ln -sf ${PWD}/.gitignore ~/.gitignore
	@ln -sf ${PWD}/starship.toml ~/.starship.toml
	git config --global core.excludesfile ~/.gitignore
