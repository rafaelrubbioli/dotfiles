default:
	@echo "deps, zsh, docker, links"

deps:
	@echo "Installing Dependencies"
	@sudo apt update
	@sudo apt install curl
	@sudo apt install git
	@sudo apt install bison
	@sudo apt install make
	@sudo apt install zsh
	@sudo apt install silversearcher-ag
	@sudo apt install aria2
	@sudo apt install htop
	@sudo apt install python3-pip
	@curl -fsSL https://starship.rs/install.sh | bash
	@curl "https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy" > /usr/bin/diff-so-fancy
	@sudo chmod +x /usr/bin/diff-so-fancy
	@sudo apt install fzf
	@sudo apt install gnome-tweaks
	@sudo apt install gnome-shell-extensions
	@curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
	@echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
	@sudo apt update
	@sudo apt install gh

zsh:
	@echo "ZSH"
	@brew install zsh zsh-completions
	@if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then \
		echo "zsh autosuggestions"; \
		git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions; \
	fi
	@cd ~/.oh-my-zsh/themes && curl https://gist.githubusercontent.com/rafaelrubbioli/e2f65c243865a06adfce59e7545c9291/raw/d1aea9589590acd909f6f0d20a6837261d79d403/kuaty.zsh-theme > kuaty.zsh-theme

docker:
	@sh -c "$$(curl -fsSL https://get.docker.com)"

links:
	@ln -sf ${PWD}/.zshrc ~/.zshrc
	@ln -sf ${PWD}/.gitconfig ~/.gitconfig
	@ln -sf ${PWD}/.gitignore ~/.gitignore
	@ln -sf ${PWD}/starship.toml ~/.starship.toml
	git config --global core.excludesfile ~/.gitignore
