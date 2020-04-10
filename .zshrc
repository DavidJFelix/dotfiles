### Added by Zplugin's installer
source $HOME/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

setopt promptsubst

zplugin ice wait lucid
zplugin snippet OMZ::lib/functions.zsh

zplugin ice wait lucid
zplugin snippet OMZ::lib/clipboard.zsh

zplugin ice wait lucid
zplugin snippet OMZ::lib/completion.zsh

zplugin ice wait lucid
zplugin snippet OMZ::lib/correction.zsh

zplugin ice wait lucid
zplugin snippet OMZ::lib/directories.zsh

zplugin ice wait lucid
zplugin snippet OMZ::lib/grep.zsh

zplugin ice wait lucid
zplugin snippet OMZ::lib/key-bindings.zsh

zplugin ice wait lucid
zplugin snippet OMZ::lib/misc.zsh

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

# zplugin ice wait lucid
# zplugin snippet OMZ::themes/gallois.zsh-theme

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

export GOPATH="$HOME/.go"
export NVM_DIR="$HOME/.nvm"

source $HOME/.cargo/env
eval "$(starship init zsh)"
