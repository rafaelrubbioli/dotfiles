export ZSH="/home/$USER/.oh-my-zsh"

# https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="kuaty"

plugins=(
  git
  wd
  kubectl
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:/usr/local/go/bin:/home/rafaelrubbioli/bin:/home/rafaelrubbioli/go/bin

export TMPDIR=/tmp

alias zource="source ~/.zshrc"
alias zshconfig="code ~/.zshrc"
alias gsync="git remote update upstream && git rebase upstream/$(git_current_branch)"

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

# git push force current branch to origin
ggpf () {
	if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]
	then
		git push origin "${*}" -f
	else
		[[ "$#" == 0 ]] && local b="$(git_current_branch)" 
		git push origin "${b:=$1}" -f
	fi
}

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# See what is running on ports
whoseport () {
    lsof -i ":$1" | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} LISTEN
}

# K8S
alias kpods="kubectl get pods | grep"
alias kjobs="kubectl get jobs | grep"
alias kcron="kubectl get cronjobs | grep"
alias kl="kubectl logs -f"
alias kpf="kubectl port-forward"
# Change namespace
kns() {
    namespace=$1
    if [ -z $namespace ]; then
        echo "Please, provide the namespace name: 'change-ns mywebapp'"
        return 1
    fi

    kubectl config set-context $(kubectl config current-context) --namespace $namespace
}