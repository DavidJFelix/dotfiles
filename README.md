[![paypal](https://img.shields.io/badge/-Donate-yellow.svg?longCache=true&style=for-the-badge)](https://www.paypal.me/ZdharmaInitiative)
[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=D54B3S7C6HGME)
[![patreon](https://img.shields.io/badge/-Patreon-orange.svg?longCache=true&style=for-the-badge)](https://www.patreon.com/psprint)
<br/>New: You can request a feature when donating, even fancy or advanced ones get implemented this way. [There are
reports](DONATIONS.md) about what is being done with the money received.

<p align="center">
<img src="https://raw.githubusercontent.com/zdharma/zplugin/master/doc/img/zplugin.png" />
</p>

[![Status][status-badge]][status-link] [![MIT License][MIT-badge]][MIT-link] [![][ver-badge]][ver-link] ![][act-badge] [![Chat at https://gitter.im/zplugin/Lobby][lobby-badge]][lobby-link]

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Getting help](#getting-help)
- [Zplugin](#zplugin)
- [Quick Start](#quick-start)
- [Quick Start Module-Only](#quick-start-module-only)
  - [More On Zplugin Zsh Module](#more-on-zplugin-zsh-module)
    - [Module – Guaranteed Compilation Of All Scripts / Plugins](#module--guaranteed-compilation-of-all-scripts--plugins)
    - [Module – Measuring Time Of `source`s](#module--measuring-time-of-sources)
- [News](#news)
- [Ice Modifiers](#ice-modifiers)
- [Usage](#usage)
    - [Using Oh-My-Zsh Themes](#using-oh-my-zsh-themes)
- [Calling compinit](#calling-compinit)
  - [Turbo-loading completions & calling compinit](#turbo-loading-completions--calling-compinit)
- [Ignoring Compdefs](#ignoring-compdefs)
- [Non-Github (Local) Plugins](#non-github-local-plugins)
- [Customizing Paths & Other](#customizing-paths--other)
- [Hint: extending Git](#hint-extending-git)
- [IRC Channel](#irc-channel)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Getting help

Besides the main-knowledge source, i.e. this README, there are subpages that are
**guides**:

 - [INSTALLATION](doc/INSTALLATION.adoc)
 - [INTRODUCTION TO ZPLUGIN](doc/INTRODUCTION.adoc)
 - [Short-narration style WIKI](https://github.com/zdharma/zplugin/wiki)

# Zplugin

**NEW**: Zplugin now has pure-Zsh [semigraphical dashboard](https://github.com/psprint/zplugin-crasis)
which allows to manipulate plugins, snippets, etc.

**NEW**: [Gallery of Zplugin Invocations](GALLERY.md)

**NEW**: **[Short-text style Wiki](https://github.com/zdharma/zplugin/wiki)**

**NEW**: [Code documentation](zsdoc)

Zplugin is an elastic and fast Zshell plugin manager that will allow you to
install everything from Github and other sites. For example, in order to install
[trapd00r/LS_COLORS](https://github.com/trapd00r/LS_COLORS), which isn't a Zsh
plugin:

```zsh
# For GNU ls (the binaries can be gls, gdircolors)

zplugin ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh"
zplugin light trapd00r/LS_COLORS
```

([explanation](https://github.com/zdharma/zplugin/wiki/LS_COLORS-explanation)). Other example: direnv written in Go, requiring building after cloning:

```zsh
# make'!...' -> run make before atclone & atpull

zplugin ice as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh"
zplugin light direnv/direnv
```

([explanation](https://github.com/zdharma/zplugin/wiki/Direnv-explanation)).

Zplugin is currently the only plugin manager out there that has **[Turbo
Mode](https://github.com/zdharma/zplugin#turbo-mode-zsh--53)** which yields **39-50%
faster Zsh startup!**

Zplugin gives **reports** from plugin load describing what aliases, functions,
bindkeys, Zle widgets, zstyles, completions, variables, `PATH` and `FPATH`
elements a plugin has set up.

Supported is **unloading** of plugin and ability to list, (un)install and
selectively disable, enable plugin's completions.

The system does not use `$FPATH`, loading multiple plugins doesn't clutter
`$FPATH` with the same number of entries (e.g. `10`). Code is immune to
`KSH_ARRAYS`. Completion management functionality is provided to allow user
to call `compinit` only once in `.zshrc`.

Looking for help? See the [Introduction](doc/INTRODUCTION.adoc) and [the
wiki](https://github.com/zdharma/zplugin/wiki).

# Quick Start

To install, execute:

```zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
```

Then add some actions (load some plugins) to `~/.zshrc`, at bottom, for example:

```zsh
zplugin load zdharma/history-search-multi-word

zplugin ice compile"*.lzui" from"notabug"
zplugin load zdharma/zui

# Binary release in archive, from Github-releases page; after automatic unpacking it provides program "fzf"

zplugin ice from"gh-r" as"program"; zplugin load junegunn/fzf-bin

# One other binary release, it needs renaming from `docker-compose-Linux-x86_64`.
# This is done by ice-mod `mv'{from} -> {to}'. There are multiple packages per
# single version, for OS X, Linux and Windows – so ice-mod `bpick' is used to
# select Linux package – in this case this is not needed, Zplugin will grep
# operating system name and architecture automatically when there's no `bpick'

zplugin ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"*linux*"; zplugin load docker/compose

# Vim repository on Github – a typical source code that needs compilation – Zplugin
# can manage it for you if you like, run `./configure` and other `make`, etc. stuff.
# Ice-mod `pick` selects a binary program to add to $PATH.

zplugin ice as"program" atclone"rm -f src/auto/config.cache; ./configure" atpull"%atclone" make pick"src/vim"
zplugin light vim/vim

# Scripts that are built at install (there's single default make target, "install",
# and it constructs scripts by `cat'ing a few files). The make"" ice could also be:
# `make"install PREFIX=$ZPFX"`, if "install" wouldn't be the only, default target

zplugin ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zplugin light tj/git-extras

# Two regular plugins loaded in default way (no `zplugin ice ...` modifiers)

zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting

# Load the pure theme, with zsh-async library that's bundled with it
zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure

# This one to be ran just once, in interactive session

zplugin creinstall %HOME/my_completions  # Handle completions without loading any plugin, see "clist" command
```

(No need to add:

```SystemVerilog
source "$HOME/.zplugin/bin/zplugin.zsh"
```

because the install script does this.)

Things used in above example config:
`history-search-multi-word` – multi-term searching of history (bound to Ctrl-R), `zui` – textual-UI library for Zshell,
see `zui-demo<TAB>`. The `ice` sub-command – add modifiers to following `zplugin load ...` command or other command.
`notabug` – the site `notabug.org`

Looking for help? See the [Introduction](doc/INTRODUCTION.adoc) and [the
wiki](https://github.com/zdharma/zplugin/wiki).

# Quick Start Module-Only

To install just the binary Zplugin module **standalone** (Zplugin is not needed, the module can be used with any
other plugin manager), execute:

```zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/mod-install.sh)"
```

This script will display what to add to `~/.zshrc` (2 lines) and show usage instructions.

## More On Zplugin Zsh Module

Zplugin users can build the module by issuing following command instead of running above `mod-install.sh` script
(the script is for e.g. `zgen` users or users of any other plugin manager):

```zsh
zplugin module build
```

This command will compile the module and display instructions on what to add to `~/.zshrc`.

### Module – Guaranteed Compilation Of All Scripts / Plugins

The module is a binary Zsh module (think about `zmodload` Zsh command, it's that topic) which transparently and
automatically **compiles sourced scripts**. Many plugin managers do not offer compilation of plugins, the module is
a solution to this. Even if a plugin manager does compile plugin's main script (like Zplugin does), the script can
source smaller helper scripts or dependency libraries (for example, the prompt `geometry-zsh/geometry` does that)
and there are very few solutions to that, which are demanding (e.g. specifying all helper files in plugin load
command and tracking updates to the plugin – in Zplugin case: by using `compile` ice-mod).

  ![image](https://raw.githubusercontent.com/zdharma/zplugin/images/mod-auto-compile.png)

### Module – Measuring Time Of `source`s

Besides the compilation-feature, the module also measures **duration** of each script sourcing. Issue `zpmod
source-study` after loading the module at top of `~/.zshrc` to see a list of all sourced files with the time the
sourcing took in milliseconds on the left. This feature allows to profile the shell startup. Also, no script can
pass-through that check and you will obtain a complete list of all loaded scripts, like if Zshell itself was
tracking this. The list can be surprising.

# News
* 12-03-2018
  - Finally reorganizing the `README.md`. Went on asciidoc path, the
    side-documents are written in it and the `README.md` will also be
    converted (example page: [Introduction](doc/INTRODUCTION.adoc))
* 12-10-2018
  - New `id-as''` ice-mod. You can nickname a plugin or snippet, to e.g. load it twice, with different `pick''`
    ice-mod, or from Github binary releases and regular Github repository at the same time. More information
    in [blog post](http://zdharma.org/2018-10-12/Nickname-a-plugin-or-snippet).

* 30-08-2018
  - New `as''` ice-mod value: `completion`. Can be used to install completion-only "plugins", even single
    files:
    ```zsh
    zplugin ice as"completion" mv"hub* -> _hub"
    zplugin snippet https://github.com/github/hub/blob/master/etc/hub.zsh_completion
    ```

  - Uplift of Git-output, it now has an animated progress-bar:

  ![image](https://raw.githubusercontent.com/zdharma/zplugin/images/zplg-progress-bar.gif)

* 15-08-2018
  - New `$ZPLGM` field `COMPINIT_OPTS` (also see [Customizing Paths](#customizing-paths--other)). You can pass
    `-C` or `-i` there to mute the `insecure directories` messages. Typical use case could be:
    ```zsh
    zplugin ice wait"5" atinit"ZPLGM[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" lucid
    zplugin light zdharma/fast-syntax-highlighting
    ```

* 13-08-2018
  - `self-update` (subcommand used to update Zplugin) now lists new commits downloaded by the update:
  ![image](https://raw.githubusercontent.com/zdharma/zplugin/images/zplg-self-update.png)

  - New subcommand `bindkeys` that lists what bindkeys each plugin has set up.

* 25-07-2018
  - If you encountered a problem with loading Turbo-Mode plugins, it is fixed now. This occurred in versions
  available between `10` and `23` of July. Issue `zplugin self-update` if you installed/updated in this period.
  - New bug-fix release `v2.07`.

* 13-07-2018
  - New `multisrc''` ice, it allows to specify multiple files for sourcing and  it uses brace expansion syntax, so for example you can:
    ```zsh
    zplugin ice depth"1" multisrc="lib/{misc,functions}.zsh" pick"/dev/null"; zplugin load robbyrussell/oh-my-zsh
    zplugin ice svn multisrc"{misc,functions}.zsh" pick""; zplugin snippet OMZ::lib
    array=( {misc,functions}.zsh ); zplg ice svn multisrc"\${array[@]}" pick""; zplugin snippet OMZ::lib
    array=( {misc,functions}.zsh ); zplg ice svn multisrc"${array[@]}" pick""; zplugin snippet OMZ::lib
    array=( {misc,functions}.zsh ); zplg ice svn multisrc"\$array" pick""; zplugin snippet OMZ::lib
    array=( {misc,functions}.zsh ); zplg ice svn multisrc"$array" pick""; zplugin snippet OMZ::lib
    zplugin ice svn multisrc"misc.zsh functions.zsh" pick""; zplugin snippet OMZ::lib
    ```
* 12-07-2018
  - For docker and new machine provisioning, there's a trick that allows to install all [turbo-mode](#turbo-mode-zsh--53)
    plugins by scripting:

    ```zsh
    zsh -i -c -- '-zplg-scheduler burst'
    ```

* 10-07-2018
  - Ice `wait'0'` now means actually short time – you can load plugins and snippets **very quickly** after prompt.

* 02-03-2018
  - Zplugin exports `$ZPFX` parameter. Its default value is `~/.zplugin/polaris` (user can
    override it before sourcing Zplugin). This directory is like `/usr/local`, a prefix
    for installed software, so it's possible to use ice like `make"PREFIX=$ZPFX"` or
    `atclone"./configure --prefix=$ZPFX"`. Zplugin also setups `$MANPATH` pointing to the
    `polaris` directory. Checkout [gallery](GALLERY.md) for examples.
  - [New README section](#hint-extending-git) about extending Git with Zplugin.

* 05-02-2018
  - I work much on this README however multi-file Wiki might be better to read – it
    [just has been created](https://github.com/zdharma/zplugin/wiki).

* 16-01-2018
  - New ice-mod `compile` which takes pattern to select additional files to compile, e.g.
    `zplugin ice compile"(hsmw-*|history-*)"` (for `zdharma/history-search-multi-word` plugin).
    See [Ice Modifiers](#ice-modifiers).

* 14-01-2018
  - Two functions have been exposed: `zpcdreplay` and `zpcompinit`. First one invokes compdef-replay,
    second one is equal to `autoload compinit; compinit` (it also respects `$ZPLGM[ZCOMPDUMP_PATH]`).
    You can use e.g. `atinit'zpcompinit'` ice-mod in a syntax-highlighting plugin, to initialize
    completion right-before setting up syntax highlighting (because that should be done at the end).

* 13-01-2018
  - New customizable path `$ZPLGM[ZCOMPDUMP_PATH]` that allows to point zplugin to non-standard
    `.zcompdump` location.
  - Tilde-expansion is now performed on the [customizable paths](#customizing-paths--other) – you can
    assign paths like `~/.zplugin`, there's no need to use `$HOME/.zplugin`.

* 31-12-2017
  - For the new year there's a new feature: user-services spawned by Zshell :) Check out
    [available services](https://github.com/zservices). They are configured like their
    READMEs say, and controlled via:

    ```
    % zplugin srv redis next    # current serving shell will drop the service, next Zshell will pick it up
    % zplugin srv redis quit    # the serving shell will quit managing the service, next Zshell will pick it up
    % zplugin srv redis stop    # stop serving, do not pass it to any shell, just hold the service
    % zplugin srv redis start   # start stopped service, without changing the serving shell
    % zplugin srv redis restart # restart service, without changing the serving shell
    ```

    This feature allows to configure everything in `.zshrc`, without the the need to deal with `systemd` or
    `launchd`, and can be useful e.g. to configure shared-variables (across Zshells), stored in `redis` database
    (details on [zservices/redis](https://github.com/zservices/redis)).

* 24-12-2017
  - Xmas present – [fast-syntax-highlighting](https://github.com/zdharma/fast-syntax-highlighting)
    now highlights the quoted part in `atinit"echo Initializing"`, i.e. it supports ICE syntax :)

* 08-12-2017
  - SVN snippets are compiled on install and update
  - Resolved how should ice-mods be remembered – general rule is that using `zplugin ice ...` makes
    memory-saved and disk-saved ice-mods not used, and replaced on update. Calling e.g. `zplugin
    update ...` without preceding `ice` uses memory, then disk-saved ices.

* 07-12-2017
  - New subcommand `delete` that obtains plugin-spec or URL and deletes plugin or snippet from disk.
    It's good to forget wrongly passed Ice-mods (which are storred on disk e.g. for `update --all`).

* 04-12-2017
  - It's possible to set plugin loading and unloading on condition. ZPlugin supports plugin unloading,
    so it's possible to e.g. **unload prompt and load another one**, on e.g. directory change. Checkout
    [full story](#automatic-loadunload-on-condition) and [Asciinema video](https://asciinema.org/a/150825).

* 29-11-2017
  - **[Turbo Mode](https://github.com/zdharma/zplugin#turbo-mode-zsh--53)** – **39-50% or more faster Zsh startup!**
  - Subcommand `update` can update snippets, via given URL (up to this point snippets were updated via
    `zplugin update --all`).
  - Completion management is enabled for snippets (not only plugins).

* 13-11-2017
  - New ice modifier – `make`. It causes the `make`-command to be executed after cloning or updating
    plugins and snippets. For example there's `Zshelldoc` that uses `Makefile` to build final scripts:

    ```SystemVerilog
    zplugin ice as"program" pick"build/zsd*" make; zplugin light zdharma/zshelldoc
    ```

    The above doesn't trigger the `install` target, but this does:

    ```SystemVerilog
    zplugin ice as"program" pick"build/zsd*" make"install PREFIX=/tmp"; zplugin light zdharma/zshelldoc
    ```

  - Fixed problem with binary-release selection (`from"gh-r"`) by adding Ice-mod `bpick`, which
    should be used for this purpose instead of `pick`, which selects file within plugin tree.

* 06-11-2017
  - The subcommand `clist` now prints `3` completions per line (not `1`). This makes large amount
    of completions to look better. Argument can be given, e.g. `6`, to increase the grouping.
  - New Ice-mod `silent` that mutes `stderr` & `stdout` of a plugin or snippet.

* 04-11-2017
  - New subcommand `ls` which lists snippets-directory in a formatted and colorized manner. Example:

  ![zplugin-ls](https://raw.githubusercontent.com/zdharma/zplugin/images/zplg-ls.png)

* 29-10-2017
  - Subversion protocol (supported by Github) can be used to clone **subdirectories** when using
    snippets. This allows to load multi-file snippets. For example:

    ```SystemVerilog
    zstyle ':prezto:module:prompt' theme smiley
    zplugin ice svn silent; zplugin snippet PZT::modules/prompt
    ```

  - Snippets support `Prezto` modules (with dependencies), and can use **PZT::** URL-shorthand,
    like in the example above. One can load `Prezto` module as single file snippet, or use Subversion
    to download whole directory (see also description of [Ice Modifiers](#ice-modifiers)):

    ```zsh
    # Single file snippet, URL points to file

    zplg snippet PZT::modules/helper/init.zsh

    # Multi-file snippet, URL points to directory to clone with Subversion
    # The file to source (init.zsh) is automatically detected

    zplugin ice svn; zplugin snippet PZT::modules/prompt

    # Use of Subversion to load an OMZ plugin

    zplugin ice svn; zplugin snippet OMZ::plugins/git
    ```

  - Fixed a bug with `cURL` usage (snippets) for downloading, it will now be properly used

* 13-10-2017
  - Snippets can use "**OMZ::**" prefix to easily point to `Oh-My-Zsh` plugins and libraries, e.g.:

    ```SystemVerilog
    zplugin snippet OMZ::lib/git.zsh
    zplugin snippet OMZ::plugins/git/git.plugin.zsh
    ```

* 12-10-2017
  - The `cd` subcommand can now obtain URL and move session to **snippet** directory
  - The `times` subcommand now includes statistics on snippets. Also, entries
    are displayed in order of loading:

    ```zsh
    % zplugin times
    Plugin loading times:
    0.010 sec - OMZ::lib/git.zsh
    0.001 sec - OMZ::plugins/git/git.plugin.zsh
    0.003 sec - zdharma/history-search-multi-word
    0.003 sec - rimraf/k
    0.003 sec - zsh-users/zsh-autosuggestions
    ```

* 24-09-2017
  - **[Code documentation](zsdoc)** for contributors and interested people.

* 13-06-2017
  - Plugins can now be absolute paths:

    ```SystemVerilog
    zplugin load %HOME/github/{directory}
    zplugin load /Users/sgniazdowski/github/{directory}
    zplugin load %/Users/sgniazdowski/github/{directory}
    ```

    Completions are not automatically installed, but user can run `zplg creinstall %HOME/github/{directory}`, etc.

* 23-05-2017
  - New `ice` modifier: `if`, to which you can provide a conditional expression:

    ```SystemVerilog
    % zplugin ice if"(( 0 ))"
    % zplugin snippet --command https://github.com/b4b4r07/httpstat/blob/master/httpstat.sh
    % zplugin ice if"(( 1 ))"
    % zplugin snippet --command https://github.com/b4b4r07/httpstat/blob/master/httpstat.sh
    Setting up snippet httpstat.sh
    Downloading httpstat.sh...
    ```

# Ice Modifiers

Following `ice` modifiers are to be passed to `zplugin ice ...` to obtain described effects.

|  Modifier | Description |
|-----------|-------------|
| `proto`   | Change protocol to `git`,`ftp`,`ftps`,`ssh`, `rsync`, etc. Default is `https`. Works with plugins (i.e. not snippets). |
| `from`    | Clone plugin from given site. Supported are `from"github"` (default), `..."github-rel"`, `..."gitlab"`, `..."bitbucket"`, `..."notabug"` (short names: `gh`, `gh-r`, `gl`, `bb`, `nb`). Can also be a full domain name (e.g. for Github enterprise). |
| `as`      | Can be `as"program"` (also alias `as"command"`), and will cause to add script/program to `$PATH` instead of sourcing (see `pick`). Can also be `as"completion"`. |
| `id-as`   | Nickname a plugin or snippet, to e.g. create a short handler for long-url snippet. See [blog post](http://zdharma.org/2018-10-12/Nickname-a-plugin-or-snippet). |
| `ver`     | Used with `from"gh-r"` (i.e. downloading a binary release, e.g. for use with `as"program"`) – selects which version to download. Default is latest, can also be explicitly `ver"latest"`. Works also with regular plugins, checkouts e.g. `ver"abranch"`, i.e. a specific version. |
| `pick`    | Select the file to source, or the file to set as command (when using `snippet --command` or ICE `as"program"`), e.g. `zplugin ice pick"*.plugin.zsh"`. Works with plugins and snippets. |
| `bpick`   | Used to select which release from Github Releases to download, e.g. `zplg ice from"gh-r" as"program" bpick"*Darwin*"; zplg load docker/compose` |
| `depth`   | Pass `--depth` to `git`, i.e. limit how much of history to download. Works with plugins. |
| `cloneopts`   | Pass the contents of `cloneopts` to `git clone`. Defaults to `--recursive` i.e. Change cloning options. Works with plugins. |
| `bindmap` | To hold `;`-separated strings like `Key(s)A -> Key(s)B`, e.g. `^R -> ^T; ^A -> ^B`. In general, `bindmap''`changes bindings (done with the `bindkey` builtin) the plugin does. The example would cause the plugin to map Ctrl-T instead of Ctrl-R, and Ctrl-B instead of Ctrl-A. |
| `trackbinds` | Shadow but only `bindkey` calls even with `zplugin light ...`, i.e. even with tracking disabled (fast loading), to allow `bindmap` to remap the key-binds. The same effect has `zplugin light -b ...`, i.e. additional `-b` option to the `light`-subcommand. |
| `if`      | Load plugin or snippet only when given condition is fulfilled, for example: `zplugin ice if'[[ -n "$commands[otool]" ]]'; zplugin load ...`. |
| `blockf`  | Disallow plugin to modify `fpath`. Useful when a plugin wants to provide completions in traditional way. Zplugin can manage completions and plugin can be blocked from exposing them. |
| `silent`  | Mute plugin's or snippet's `stderr` & `stdout`. Also skip `Loaded ...` message under prompt for `wait`, etc. loaded plugins, and completion-installation messages. |
| `lucid`   | Skip `Loaded ...` message under prompt for `wait`, etc. loaded plugins (a subset of `silent`). |
| `mv`      | Move file after cloning or after update (then, only if new commits were downloaded). Example: `mv "fzf-* -> fzf"`. It uses `->` as separator for old and new file names. Works also with snippets. |
| `cp`      | Copy file after cloning or after update (then, only if new commits were downloaded). Example: `cp "docker-c* -> dcompose"`. Ran after `mv`. Works also with snippets. |
| `atinit`  | Run command after directory setup (cloning, checking it, etc.) of plugin/snippet but before loading. |
| `atclone` | Run command after cloning, within plugin's directory, e.g. `zplugin ice atclone"echo Cloned"`. Ran also after downloading snippet. |
| `atload`  | Run command after loading, within plugin's directory. Can be also used with snippets. Passed code can be preceded with `!`, it will then be tracked (if using `load`, not `light`). |
| `atpull`  | Run command after updating (**only if new commits are waiting for download**), within plugin's directory. If starts with "!" then command will be ran before `mv` & `cp` ices and before `git pull` or `svn update`. Otherwise it is ran after them. Can be `atpull'%atclone'`, to repeat `atclone` Ice-mod. To be used with plugins and snippets. |
| `svn`     | Use Subversion for downloading snippet. Github supports `SVN` protocol, this allows to clone subdirectories as snippets, e.g. `zplugin ice svn; zplugin snippet OMZ::plugins/git`. Other ice `pick` can be used to select file to source (default are: `*.plugin.zsh`, `init.zsh`, `*.zsh-theme`). |
| `make`    | Run `make` command after cloning/updating and executing `mv`, `cp`, `atpull`, `atclone` Ice mods. Can obtain argument, e.g. `make"install PREFIX=/opt"`. If the value starts with `!` then `make` is ran before `atclone`/`atpull`, e.g. `make'!'`. |
| `src`     | Specify additional file to source after sourcing main file or after setting up command (via `as"program"`). |
| `wait`    | Postpone loading a plugin or snippet. For `wait'1'`, loading is done `1` second after prompt. For `wait'[[ ... ]]'`, `wait'(( ... ))'`, loading is done when given condition is meet. For `wait'!...'`, prompt is reset after load. Zsh can start 39% faster thanks to postponed loading (result obtained in test with `11` plugins). |
| `load`    | A condition to check which should cause plugin to load. It will load once, the condition can be still true, but will not trigger second load (unless plugin is unloaded earlier, see `unload` below). E.g.: `load'[[ $PWD = */github* ]]'`. |
| `unload`  | A condition to check causing plugin to unload. It will unload once, then only if loaded again. E.g.: `unload'[[ $PWD != */github* ]]'`. |
| `service` | Make following plugin or snippet a *service*, which will be ran in background, and only in single Zshell instance. See [zservices org](https://github.com/zservices). |
| `compile` | Pattern (+ possible `{...}` expansion, like `{a/*,b*}`) to select additional files to compile, e.g. `compile"(pure\|async).zsh"` for `sindresorhus/pure`. |
| `nocompletions` | Don't detect, install and manage completions for this plugin. Completions can be installed later with `zplugin creinstall {plugin-spec}`. |
| `nocompile` | Don't try to compile `pick`-pointed files. If passed the exclamation mark (i.e. `nocompile'!'`), then do compile, but after `make''` and `atclone''` (useful if Makefile installs some scripts, to point `pick''` at location of installation). |
| `multisrc` | Allows to specify multiple files for sourcing, enumerated with spaces as the separator (e.g. `multisrc'misc.zsh grep.zsh'`) and also using brace-expansion syntax (e.g. `multisrc'{misc,grep}.zsh'`). |

Order of related Ice-mods: `atinit` -> `atpull!` -> `make'!!'` -> `mv` -> `cp` -> `make!` -> `atclone`/`atpull` -> `make` -> `(plugin script loading)` -> `src` -> `multisrc` -> `atload`.

# Usage

```
% zpl help
Usage:
-h|--help|help               - usage information
man                          - manual
self-update                  - updates and compiles Zplugin
times                        - statistics on plugin load times, sorted in order of loading
zstatus                      - overall Zplugin status
load {plg-spec}              - load plugin, can also receive absolute local path
light [-b] {plg-spec}        - light plugin load, without reporting/tracking (-b - do track but bindkey-calls only)
unload {plg-spec}            - unload plugin loaded with `zplugin load ...', -q - quiet
snippet [-f] {URL}           - source local or remote file (by direct {URL}), -f: force - don't use cache
ls                           - list snippets in formatted and colorized manner
ice <ice specification>      - add ICE to next command, argument is e.g. from"gitlab"
update [-q] {plg-spec}|{URL} - Git update plugin or snippet (or all plugins and snippets if --all passed); besides -q accepts also --quiet
status {plg-spec}|{URL}      - Git status for plugin or svn status for snippet (or for all those if --all passed)
report {plg-spec}            - show plugin's report (or all plugins' if --all passed)
delete {plg-spec}|{URL}      - remove plugin or snippet from disk (good to forget wrongly passed ice-mods)
loaded|list [keyword]        - show what plugins are loaded (filter with 'keyword')
cd {plg-spec}                - cd into plugin's directory; also support snippets, if feed with {URL}
create {plg-spec}            - create plugin (also together with Github repository)
edit {plg-spec}              - edit plugin's file with $EDITOR
glance {plg-spec}            - look at plugin's source (pygmentize, {,source-}highlight)
stress {plg-spec}            - test plugin for compatibility with set of options
changes {plg-spec}           - view plugin's git log
recently [time-spec]         - show plugins that changed recently, argument is e.g. 1 month 2 days
clist|completions            - list completions in use
cdisable cname               - disable completion `cname'
cenable cname                - enable completion `cname'
creinstall {plg-spec}        - install completions for plugin, can also receive absolute local path; -q - quiet
cuninstall {plg-spec}        - uninstall completions for plugin
csearch                      - search for available completions from any plugin
compinit                     - refresh installed completions
dtrace|dstart                - start tracking what's going on in session
dstop                        - stop tracking what's going on in session
dunload                      - revert changes recorded between dstart and dstop
dreport                      - report what was going on in session
dclear                       - clear report of what was going on in session
compile {plg-spec}           - compile plugin (or all plugins if --all passed)
uncompile {plg-spec}         - remove compiled version of plugin (or of all plugins if --all passed)
compiled                     - list plugins that are compiled
cdlist                       - show compdef replay list
cdreplay [-q]                - replay compdefs (to be done after compinit), -q - quiet
cdclear [-q]                 - clear compdef replay list, -q - quiet
srv {service-id} [cmd]       - control a service, command can be: stop,start,restart,next,quit; `next' moves the service to another Zshell
recall {plg-spec}|{URL}      - fetch saved ice modifiers and construct `zplugin ice ...' command
env-whitelist [-v]           - allows to specify names (also patterns) of variables left unchanged during an unload. -v - verbose
bindkeys                     - lists bindkeys set up by each plugin
module                       - manage binary Zsh module shipped with Zplugin, see `zplugin module help'

Available ice-modifiers: proto from cloneopts depth if wait load unload blockf
                         pick bpick src as ver silent svn mv cp atinit atclone
                         atload atpull make service bindmap trackbinds nocompile
                         nocompletions
```

### Using Oh-My-Zsh Themes

To use **themes** created for `Oh-My-Zsh` you might want to first source the `git` library there:

```SystemVerilog
zplugin snippet http://github.com/robbyrussell/oh-my-zsh/raw/master/lib/git.zsh
# Or using OMZ:: shorthand:
zplugin snippet OMZ::lib/git.zsh
```

If the library will not be loaded, then similar to following errors will be appearing:

```
........:1: command not found: git_prompt_status
........:1: command not found: git_prompt_short_sha
```

Then you can use the themes as snippets (`zplugin snippet {file path or Github URL}`).
Some themes require not only `Oh-My-Zsh's` Git **library**, but also Git **plugin** (error
about `current_branch` function can be appearing). Load this Git-plugin as single-file
snippet directly from OMZ:

```SystemVerilog
zplugin snippet OMZ::plugins/git/git.plugin.zsh
```

Such lines should be added to `.zshrc`. Snippets are cached locally, use `-f` option to download
a fresh version of a snippet, or `zplugin update {URL}`. Can also use `zplugin update --all` to
update all snippets (and plugins).

Most themes require `promptsubst` option (`setopt promptsubst` in `zshrc`), if it isn't set, then
prompt will appear as something like: `... $(build_prompt) ...`.

You might want to supress completions provided by the git plugin by issuing `zplugin cdclear -q`
(`-q` is for quiet) – see below **Ignoring Compdefs**.

To summarize:

```SystemVerilog
# Load OMZ Git library
zplugin snippet OMZ::lib/git.zsh

# Load Git plugin from OMZ
zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin cdclear -q # <- forget completions provided up to this moment

setopt promptsubst

# Load theme from OMZ
zplugin snippet OMZ::themes/dstufft.zsh-theme

# Load normal Github plugin with theme depending on OMZ Git library
zplugin light NicoSantangelo/Alpharized
```

# Calling compinit

With no turbo mode in use, compinit can be called normally, i.e.: as `autoload compinit:
compinit`. This should be done after loading of all plugins and before possibly calling
`zplugin cdreplay`.  Also, plugins aren't allowed to simply run `compdefs`. You can
decide whether to run `compdefs` by issuing `zplugin cdreplay` (reads: `compdef`-replay).
To summarize:

```sh
source ~/.zplugin/bin/zplugin.zsh

zplugin load "some/plugin"
...
compdef _gnu_generic fd  # this will be intercepted by Zplugin, because as the compinit
                         # isn't yet loaded, thus there's no such function `compdef'; yet
                         # Zplugin provides its own `compdef' function which saves the
                         # completion-definition for later possible re-run with `zplugin
                         # cdreplay` or `zpcdreplay` (the second one can be used in hooks
                         # like atload'', atinit'', etc.)
...
zplugin load "other/plugin"

autoload -Uz compinit
compinit

zplugin cdreplay -q # -q is for quiet; actually run all the `compdef's saved before
                    #`compinit` call (`compinit' declares the `compdef' function, so
                    # it cannot be used until `compinit` is ran; Zplugin solves this
                    # via intercepting the `compdef'-calls and storing them for later
                    # use with `zplugin cdreplay')
```

This allows to call compinit once.
Performance gains are huge, example shell startup time with double `compinit`: **0.980** sec, with
`cdreplay` and single `compinit`: **0.156** sec.

## Turbo-loading completions & calling compinit

If you load completions using `wait''` turbo-mode then you can add
`atinit'zpcompinit'` to syntax-highlighting plugin (which should be the last
one loaded, as their (2 projects, [z-sy-h](https://github.com/zsh-users/zsh-syntax-highlighting) &
[f-sy-h](https://github.com/zdharma/fast-syntax-highlighting))
 documentation state), or `atload'zpcompinit'` to last
completion-related plugin. `zpcompinit` is a function that just runs `autoload
compinit; compinit`, created for convenience. There's also `zpcdreplay` which
will replay any caught compdefs so you can also do: `atinit'zpcompinit;
zpcdreplay'`, etc. Basically, it's the same as normal `compinit` call, but it
is done in `atinit` or `atload` hook of the last related plugin.

# Ignoring Compdefs

If you want to ignore compdefs provided by some plugins or snippets, place their load commands
before commands loading other plugins or snippets, and issue `zplugin cdclear`:

```SystemVerilog
source ~/.zplugin/bin/zplugin.zsh
zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin cdclear -q # <- forget completions provided by Git plugin

zplugin load "some/plugin"
...
zplugin load "other/plugin"

autoload -Uz compinit
compinit
zplugin cdreplay -q # <- execute compdefs provided by rest of plugins
zplugin cdlist # look at gathered compdefs
```

# Non-Github (Local) Plugins

Use `create` subcommand with user name `_local` (the default) to create plugin's
skeleton in `$ZPLGM[PLUGINS_DIR]`. It will be not connected with Github repository (because of user name
being `_local`). To enter the plugin's directory use `cd` command with just
plugin's name (without `_local`, it's optional).

The special user name `_local` is optional also for other commands, e.g. for
`load` (i.e. `zplugin load myplugin` is sufficient, there's no need for
`zplugin load _local/myplugin`).

If user name will not be `_local`, then Zplugin will create repository also on Github and setup correct repository origin.

# Customizing Paths & Other

Following variables can be set to custom values, before sourcing Zplugin. The
previous global variables like `$ZPLG_HOME` have been removed to not pollute
the namespace – there's single `$ZPLGM` hash instead of `5` string variables.
Please update your dotfiles.

```
declare -A ZPLGM  # initial Zplugin's hash definition, if configuring before loading Zplugin, and then:
```
| Hash Field | Description |
-------------|--------------
| ZPLGM[BIN_DIR]         | Where Zplugin code resides, e.g.: "~/.zplugin/bin"                      |
| ZPLGM[HOME_DIR]        | Where Zplugin should create all working directories, e.g.: "~/.zplugin" |
| ZPLGM[PLUGINS_DIR]     | Override single working directory – for plugins, e.g. "/opt/zsh/zplugin/plugins" |
| ZPLGM[COMPLETIONS_DIR] | As above, but for completion files, e.g. "/opt/zsh/zplugin/root_completions"     |
| ZPLGM[SNIPPETS_DIR]    | As above, but for snippets |
| ZPLGM[ZCOMPDUMP_PATH]  | Path to `.zcompdump` file, with the file included (i.e. it's name can be different) |
| ZPLGM[COMPINIT_OPTS]   | Options for `compinit` call (i.e. done by `zpcompinit`), use to pass -C to speed up loading |
| ZPLGM[MUTE_WARNINGS]   | If set to `1`, then mutes some of the Zplugin warnings, specifically the `plugin already registered` warning |

There is also `$ZPFX`, set by default to `~/.zplugin/polaris` – a directory
where software with `Makefile`, etc. can be pointed to, by e.g. `atclone'./configure --prefix=$ZPFX'`.

# Hint: extending Git

There are several projects that provide git extensions. Installing them with
Zplugin has many benefits:

 - all files are under `$HOME` – no administrator rights needed,
 - declarative setup (like Chef or Puppet) – copying `.zshrc` to different account
   brings also git-related setup,
 - easy update by e.g. `zplugin update --all`.

Below is a configuration that adds multiple git extensions, loaded in Turbo Mode,
two seconds after prompt:

```zsh
zplugin ice wait"2" lucid as"program" pick"bin/git-dsf"
zplugin light zdharma/zsh-diff-so-fancy
zplugin ice wait"2" lucid as"program" pick"$ZPFX/bin/git-now" make"prefix=$ZPFX install"
zplugin light iwata/git-now
zplugin ice wait"2" lucid as"program" pick"$ZPFX/bin/git-alias" make"PREFIX=$ZPFX" nocompile
zplugin light tj/git-extras
zplugin ice wait"2" lucid as"program" atclone'perl Makefile.PL PREFIX=$ZPFX' atpull'%atclone' \
            make'install' pick"$ZPFX/bin/git-cal"
zplugin light k4rthik/git-cal
```

Target directory for installed files is `$ZPFX` (`~/.zplugin/polaris` by default).

# IRC Channel
Connect to [chat.freenode.net:6697](ircs://chat.freenode.net:6697/%23zplugin) (SSL) or [chat.freenode.net:6667](irc://chat.freenode.net:6667/%23zplugin) and join #zplugin.

Following is a quick access via Webchat [![IRC](https://kiwiirc.com/buttons/chat.freenode.net/zplugin.png)](https://kiwiirc.com/client/chat.freenode.net:+6697/#zplugin)

[status-badge]: https://travis-ci.org/zdharma/zplugin.svg?branch=master
[status-link]: https://travis-ci.org/zdharma/zplugin
[MIT-badge]: https://img.shields.io/badge/license-MIT-blue.svg
[MIT-link]: ./LICENSE
[ver-badge]: https://img.shields.io/github/tag/zdharma/zplugin.svg
[ver-link]: https://github.com/zdharma/zplugin/releases
[act-badge]: https://img.shields.io/github/commit-activity/y/zdharma/zplugin.svg
[lobby-badge]: https://badges.gitter.im/zplugin/Lobby.svg
[lobby-link]: https://gitter.im/zplugin/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge
