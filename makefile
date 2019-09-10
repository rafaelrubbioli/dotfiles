default:
	@echo "go, deps, zsh, docker, links	"

go:
	@sudo rm -rf /usr/local/go && curl --silent https://golang.org/dl/ 2>&1 |\
		ag -o 'https://dl.google.com/go/go([0-9.]+).linux-amd64.tar.gz' |\
		head -n 1 |\
		xargs -I@ sh -c 'curl -O @; echo @ | ag -o "(go[0-9\.]+.+)" | xargs -I % sh -c "sudo tar -C /usr/local -xzf % && rm %"'

deps:
	@echo "Installing Dependencies"
	@sudo apt update && sudo apt install \
		curl git bison gcc make zsh silversearcher-ag autojump aria2 xsel \
		terminator htop python3-pip

zsh:
	@echo "oh-my-zsh, https://github.com/robbyrussell/oh-my-zsh"
	@sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	@echo "zsh autosuggestions"
	@git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	@echo "you need to logout and login again to finish installing zsh"

docker:
	@xdg-open "https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository"

links:
	@if [ ! -L "../.zshrc" ]; then \
		echo "~/.zshrc"; \
		rm -f ../.zshrc; \
		ln -s ${PWD}/zshrc ~/.zshrc; \
	fi
	@if [ ! -L "../.gitconfig" ]; then \
		echo "~/.gitconfig"; \
		rm -f ../.gitconfig; \
		ln -s ${PWD}/gitconfig ~/.gitconfig; \
	fi
	