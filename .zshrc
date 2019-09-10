export ZSH="/home/$USER/.oh-my-zsh"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(
  git
  wd
  kubectl
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

alias zshconfig="code ~/.zshrc"

export PATH=$PATH:/usr/local/go/bin:/home/rafaelrubbioli/bin:/home/rafaelrubbioli/go/bin

export TMPDIR=/tmp

qq() {
    clear
    local gpath="${GOPATH:-$HOME/go}"
    "${gpath%%:*}/src/github.com/y0ssar1an/q/q.sh" "$@"
}
rmqq() {
    if [[ -f "$TMPDIR/q" ]]; then
        rm "$TMPDIR/q"
    fi
    qq
}


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

ggpf () {
	if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]
	then
		git push origin "${*}" -f
	else
		[[ "$#" == 0 ]] && local b="$(git_current_branch)" 
		git push origin "${b:=$1}" -f
	fi
}

# SS

export GOPRIVATE=github.com/StudioSol/*