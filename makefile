default:
	@echo "go, deps, zsh, docker, links"

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

docker:
	@sh -c "$$(curl -fsSL https://get.docker.com)"

links:
	@ln -sf ${PWD}/.zshrc ~/.zshrc
	@ln -sf ${PWD}/.gitconfig ~/.gitconfig
	