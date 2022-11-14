export ZSH="$HOME/.oh-my-zsh"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export GOPATH="$HOME/.go"
export NVM_DIR="$HOME/.nvm"

source $HOME/.cargo/env
source /opt/homebrew/opt/asdf/libexec/asdf.sh

eval "$(starship init zsh)"

