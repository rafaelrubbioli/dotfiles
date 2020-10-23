default:
	@echo "go, deps, zsh, docker, links, editor, k8s"

go:
	@sudo rm -rf /usr/local/go && curl https://golang.org/dl/ 2>&1 |\
		ag -o 'https://dl.google.com/go/go([0-9.]+).linux-amd64.tar.gz' |\
		head -n 1 |\
		xargs -I@ sh -c 'curl -O @; echo @ | ag -o "(go[0-9\.]+.+)" | xargs -I % sh -c "sudo tar -C /usr/local -xzf % && rm %"'

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

zsh:
	@echo "ZSH"
	@if ! which zsh > /dev/null; then \
		echo "oh-my-zsh, https://github.com/robbyrussell/oh-my-zsh"; \
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"; \
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
	@ln -sf ${PWD}/.gitignore ~/.gitignore
	@ln -sf ${PWD}/.starship ~/.starship
	git config --global core.excludesfile ~/.gitignore

editor:
	echo "[Default Applications]" > ~/.local/share/applications/mimeapps.list
	cat /usr/share/applications/defaults.list | ag gedit.desktop | sed -e 's/=.*gedit.desktop/=code.desktop/g' >> ~/.local/share/applications/mimeapps.list

k8s:
	sudo apt-get update && sudo apt-get install -y apt-transport-https
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
	echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubectl
