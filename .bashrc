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

PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# python development environment
export WORKON_HOME=$HOME/code/python/.virtualenvs
export PIP_REQUIRE_VIRTUALENV=true
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

# git config
#ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts # setup known_hosts w/github rsa
git config --global user.email "$GIT_AUTHOR_EMAIL"
git config --global user.name "$GIT_AUTHOR_NAME"
git config --global push.default simple
git config --global core.editor vim
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.br branch
git config --global alias.hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
