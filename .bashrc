#!/usr/bin/env bash
# set editor
export EDITOR=${EDITOR}

if [[ -f ${HOME}/.bashrc.ubuntu ]]; then
    source ${HOME}/.bashrc.ubuntu
fi

if [[ -f ${HOME}/.bashrc.ubuntu.override ]]; then
    source ${HOME}/.bashrc.ubuntu.override
fi

if [[ -f ${HOME}/.bash_aliases ]]; then
    source ${HOME}/.bash_aliases
fi

if [[ -f ${HOME}/.env_vars ]]; then
    source ${HOME}/.env_vars
fi

if [[ -f ${HOME}/.env_paths ]]; then
    source ${HOME}/.env_paths
fi

# prevent a massive spawn of ssh-agent agents
ssh-add -l &>/dev/null
if [ "$?" -ne 0 ]; then
    test -r ~/.ssh-agent && \
    eval "$(<~/.ssh-agent)" >/dev/null
    
    ssh-add -l &>/dev/null
    if [ "$?" -ne 0 ]; then
        (umask 066; ssh-agent > ~/.ssh-agent)
        eval "$(<~/.ssh-agent)" >/dev/null
        find ~/.ssh -type f -name id_rsa* -not -name *.pub -exec ssh-add {} \;
    fi
fi

# set prompt_command
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# set PS1                                                                       
export PS1='\[\033]0;\u@\h:\w\007\]\[\033[1;32m\]\n[ \w ]\n\[\033[1;39m\]\u@\h \[\033[1;31m\]>> \[\033[m\]'

# python development environment
export WORKON_HOME=$HOME/code/python/.virtualenvs
#export PIP_REQUIRE_VIRTUALENV=true
export PROJECT_HOME=$HOME/code/python
export VIRTUALENVWRAPPER_PYTHON=$VIRTUALENVWRAPPER_PYTHON
export VIRTUALENVWRAPPER_VIRTUALENV=$VIRTUALENVWRAPPER_VIRTUALENV
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
mkdir -p $WORKON_HOME
if [[ -f ${VIRTUALENVWRAPPER_SHELL} ]]; then
    source ${VIRTUALENVWRAPPER_SHELL}
fi

gpip () {
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

alias java7="export JAVA_HOME=\"$JAVA_7_HOME\""
alias java8="export JAVA_HOME=\"$JAVA_8_HOME\""
alias java9="export JAVA_HOME=\"$JAVA_9_HOME\""

# default java version
export JAVA_HOME=$JAVA_8_HOME

# export git user
export GIT_AUTHOR_NAME="\"${GIT_AUTHOR_NAME}\""
export GIT_AUTHOR_EMAIL="\"${GIT_AUTHOR_EMAIL}\""

# npm/node config
[[ ! -d ${NPM_PACKAGES} ]] && mkdir ${NPM_PACKAGES} || export PATH="${NPM_PACKAGES}/bin:${PATH}"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# TODO... need to add nvm config to pickup .nvm/nvm.sh
