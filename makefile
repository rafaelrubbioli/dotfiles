default:
	@echo "go, deps, zsh, docker, links, editor"

go:
	@sudo rm -rf /usr/local/go && curl --silent https://golang.org/dl/ 2>&1 |\
		ag -o 'https://dl.google.com/go/go([0-9.]+).linux-amd64.tar.gz' |\
		head -n 1 |\
		xargs -I@ sh -c 'curl -O @; echo @ | ag -o "(go[0-9\.]+.+)" | xargs -I % sh -c "sudo tar -C /usr/local -xzf % && rm %"'

deps:
	@echo "Installing Dependencies"
	@sudo apt update && sudo apt install \
		curl git bison make zsh silversearcher-ag aria2 \
		terminator htop python3-pip
	@curl -fsSL https://starship.rs/install.sh | bash

zsh:
	@echo "ZSH"
	@if ! which zsh > /dev/null; then \
		echo "oh-my-zsh, https://github.com/robbyrussell/oh-my-zsh"; \
		sh -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"; \
		echo "you should logout and login again"; \
	fi
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
	@ln -sf ${PWD}/.starship ~/.starship

editor:
	echo "[Default Applications]" > ~/.local/share/applications/mimeapps.list
	cat /usr/share/applications/defaults.list | ag gedit.desktop | sed -e 's/=.*gedit.desktop/=code.desktop/g' >> ~/.local/share/applications/mimeapps.list