### Added by Zplugin's installer
source $HOME/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

setopt promptsubst
zplugin ice wait'!1' lucid
zplugin snippet https://raw.githubusercontent.com/nvm-sh/nvm/master/nvm.sh

zplugin ice wait lucid
zplugin snippet OMZ::lib/git.zsh

zplugin ice wait lucid
zplugin snippet OMZ::lib/theme-and-appearance.zsh

zplugin ice wait lucid
zplugin snippet OMZ::lib/compfix.zsh

zplugin ice wait lucid
zplugin snippet OMZ::lib/history.zsh

zplugin ice wait lucid
zplugin snippet OMZ::plugins/git/git.plugin.zsh

zplugin ice wait lucid
zplugin snippet OMZ::lib/prompt_info_functions.zsh

zplugin ice wait lucid
zplugin snippet OMZ::lib/spectrum.zsh

zplugin ice wait lucid
zplugin snippet OMZ::themes/gallois.zsh-theme

zplugin ice wait'2' lucid
zplugin snippet https://raw.githubusercontent.com/nvm-sh/nvm/master/nvm.sh

zplugin ice wait lucid
zplugin snippet $HOME/.cargo/env

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

export GOPATH="~/.go"
export NVM_DIR="$HOME/.nvm"

#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#source $HOME/.cargo/env
