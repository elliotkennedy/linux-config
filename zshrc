# Check if a command is available
# Returns "true" or "false" rather than an exit code so that this file can be sourced
function isInstalled() {
    if ! type "$1" &> /dev/null; then
        echo "false"
    else
        echo "true"
   fi
}

# Debug logging
#export ZSHRC_LOG_LEVEL="DEBUG"

function logDebug() {
    if [[ $ZSHRC_LOG_LEVEL = "DEBUG" ]]; then
       echo $1
    fi
}

setopt autocd extendedglob nomatch notify share_history hist_ignore_all_dups HIST_IGNORE_SPACE COMPLETE_ALIASES PROMPT_SUBST

# The following lines were added by compinstall
zstyle :compinstall filename ''"$HOME"'/.zshrc'''

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Bindkeys
bindkey -e
bindkey ";5C" forward-word
bindkey ";5D" backward-word
bindkey "^[[3~" delete-char
bindkey "^[[3~" delete-char
bindkey "^H" backward-delete-word
bindkey "^[[3;5~" delete-word

bindkey '^?' backward-delete-char
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char 
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# Carry over aliases to watch and sudo
alias sudo='sudo '
alias watch='watch '

# zsudo helper function to run functions loaded in this file as root
function zsudo() { 
    sudo zsh -c "$functions[$1]" "$@"
}

# Some more aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias ee=' exit'

# You may want to put all your additions into a directory like
# ~/.zsh_aliases.d, instead of adding them here directly.
if [ -d ~/.zsh_aliases.d ]; then
    for file in ~/.zsh_aliases.d/*(N); do
        logDebug "Sourcing file - $file"
        source $file
    done
fi

# You may want to put all your additions into a directory like
# ~/.zsh_functions.d, instead of adding them here directly.
if [ -d ~/.zsh_functions.d ]; then
    for file in ~/.zsh_functions.d/*(N); do
        logDebug "Sourcing file - $file"
        source $file
    done
fi

# List of commands to exclude from session history
# Most commands should be blacklisted in ~/.hstr_blacklist or ~/.hh_blacklist
HIST_IGNORE_COMMANDS=()

# set a colour prompt
case "$TERM" in
    xterm-*color)
        colour_prompt=yes
        ;;
    *)
        logDebug "Using non-colour prompt"
        ;;
esac

# If this is an xterm set PS1 & window title
case "$TERM" in
xterm*|rxvt*)

    local FG=""
	local BG=""
	local AT=""
	local HCOLOUR=""
    local ICOLOUR=""
    local PERCENT=""
    local DTCOLOUR=""

    if [[ "$colour_prompt" = yes ]]; then
	    FG="%F{81}"
	    BG="%F{245}"
	    AT="%F{245}"
	    HCOLOUR="%F{206}"
        ICOLOUR="%F{249}"
        PERCENT="%F{130}"
        DTCOLOUR="%F{206}"
    fi

    autoload -Uz vcs_info
    zstyle ':vcs_info:*' enable git cvs svn
    zstyle ':vcs_info:*' actionformats '(%b) '
    zstyle ':vcs_info:*' formats '(%b) '

    precmd() {
        vcs_info # load vcs info
        print -Pn "\e]0;%n@%M: %~\a" # set title
    }

    preexec() {
        print -Pn "\e]0;%# $1 | %n@%M: %~\a" # set title with executing command
    }

    PROMPT=''"${FG}%n${AT}@${HCOLOUR}%m ${BG}%~ "'${vcs_info_msg_0_}'"${PERCENT}%#${ICOLOUR} "''
    RPROMPT="${BG}[${DTCOLOUR}%D %*${BG}]"

    unset FG
    unset BG
    unset AT
    unset HCOLOUR
    unset ICOLOUR
    unset PERCENT
    unset DTCOLOUR
    ;;
*)
    ;;
esac

# Editors
export PAGER=less
export VISUAL=vim
export EDITOR=vim
# grep highlight magenta
export GREP_COLORS="ms=1;38;5;206"

# History
export HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# hstr configuration
if [[ $(isInstalled hstr) = "true" ]];
then
    # Some distros symlink hh
    if [[ $(isInstalled hh) = "false" ]]; then
        alias hh='hstr'
    fi
    export HSTR_CONFIG=hicolor        # get more colors
    #bindkey -s "\C-r" "\eqhstr\n"     # bind hstr to Ctrl-r
    bindkey -s "\C-r" "\C-a hh -- \C-j" # preceding ' ' + setop HIST_IGNORE_SPACE will ensure this is ignored from the history
    HIST_IGNORE_COMMANDS+=('hstr' 'hh')
    export HSTR_CONFIG="$HSTR_CONFIG blacklist"
else
    logDebug "hstr is not installed"
fi

# Ignore certain commands from history
if [[ -n "${HIST_IGNORE_COMMANDS}" ]];
then
    # Hook function to exclude commands from history
    zshaddhistory() {
        local cmd=${1%%$'\n'}
        local cmd=${cmd%% *}
        #whence ${${(z)1}[1]} >| /dev/null || return 1;
        if (( $HIST_IGNORE_COMMANDS[(Ie)$cmd] )); then
             logDebug "Excluded $cmd command from zsh history"
             return 1;
        fi
        return 0;
    }
    #logDebug $(printf '%s\n' "${HIST_IGNORE_COMMANDS[@]}")
    #logDebug "Commands excluded from history - \n\t- ${HIST_IGNORE_COMMANDS[*]}" )
fi

# Ranger file browser
if [[ $(isInstalled ranger) = "true" ]];
then
    alias rr=' ranger'
fi

# Antibody plugin manager
if [[ -f ~/.zsh_plugins.sh ]];
then
    local use_autosuggestions="true"
    if [[ $use_autosuggestions = "true" ]];
    then
        # bindkey '^[M' autosuggest-execute
        if [[ $colour_prompt = "yes" ]];
        then
            ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=206,bg=81,bold,underline"
        else
            ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=0,bg=2,bold,underline"
        fi
        ZSH_AUTOSUGGEST_USE_ASYNC=1 # can be set to anything to enable
        ZSH_AUTOSUGGEST_STRATEGY=(history completion) # match_prev_cmd will not work with history truncation
        # ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20 # 20 recommended
        # ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *"
        # ZSH_AUTOSUGGEST_COMPLETION_IGNORE="cd *"
    fi
    source ~/.zsh_plugins.sh
fi

# Cleanup
unfunction isInstalled

echo ""
neofetch --ascii_colors 81 206 245 249 130 --colors 81 81 249 206 245
echo ""

