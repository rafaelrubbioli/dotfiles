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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

export STARSHIP_CONFIG=~/.starship.toml
eval "$(starship init zsh)"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# ALIAS AND FUNCTIONS

alias zource="source ~/.zshrc"
alias zshconfig="code ~/.zshrc"

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

# GIT
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

# checkout branch with list
alias gcol='git checkout $(git branch --sort=-committerdate | fzf)'

# fetches latest version of branch
gsync () {
    branch=$1
    if [ -z $branch ]; then
        branch=$(git_current_branch)
    fi

    git fetch upstream $branch
    git rebase upstream/$branch
}

# GH CLI
# checkout PR with list
alias ghpr='gh pr list | fzf | awk "{print \$1}" | xargs -I @ gh pr checkout @'

# See what is running on ports
whoseport () {
    lsof -i ":$1" | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} LISTEN
}

# K8S
kpods() {
    pod=$1
    if [ -z $pod ]; then
        kubectl get pods
        return 0
    fi

    kubectl get pods | grep $pod
}

kjobs() {
    job=$1
    if [ -z $job ]; then
        kubectl get jobs
        return 0
    fi

    kubectl get jobs | grep $job
}

kcronjobs() {
    cronjob=$1
    if [ -z $cronjob ]; then
        kubectl get cronjobs
        return 0
    fi

    kubectl get cronjobs | grep $cronjob
}

kservices() {
    service=$1
    if [ -z $service ]; then
        kubectl get services
        return 0
    fi

    kubectl get services | grep $service
}

ksvcs() {
    service=$1
    if [ -z $service ]; then
        kubectl get services
        return 0
    fi

    kubectl get services | grep $service
}

kdeployments() {
    deployment=$1
    if [ -z $deployment ]; then
        kubectl get deployment
        return 0
    fi

    kubectl get deployments | grep $deployment
}

alias kpod="kubectl describe pod"
alias kdeploy="kubectl describe deploy"
alias kservice="kubectl describe service"
alias kjob="kubectl describe job"
alias kcronjob="kubectl describe cronjob"
alias ksvc="kubectl describe service"

alias kl="kubectl logs -f"
kll() {
    name=$1
    kubectl get pods | grep $name | awk '{print $1}' | xargs -I {} kubectl logs -f {}
}

alias kpf="kubectl port-forward"

alias kcontext='context=$(kubectl config get-contexts -o name | fzf); kubectl config use-context $context'

alias kubesh='pod=$(kubectl get pods -o custom-columns=":metadata.name" --no-headers | fzf); kubectl exec -ti $pod -- bash || kubectl exec -ti $pod -- sh'

# Change namespace
kns() {
    namespace=$1
    if [ -z $namespace ]; then
        echo "Please, provide the namespace name: 'kns [namespace]'"
        kubectl get namespaces
        return 1
    fi

    kubectl config set-context $(kubectl config current-context) --namespace $namespace
}
