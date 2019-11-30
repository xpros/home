#!/usr/bin/env bash
# set editor
export EDITOR="${EDITOR}"

[[ -f "${HOME}/.bashrc.ubuntu" ]] && \. "${HOME}/.bashrc.ubuntu"

[[ -f "${HOME}/.bashrc.ubuntu.override" ]] && \. "${HOME}/.bashrc.ubuntu.override"

[[ -f "${HOME}/.bash_aliases" ]] && \. "${HOME}/.bash_aliases"

[[ -f "${HOME}/.env_vars" ]] && \. "${HOME}/.env_vars"

[[ -f "${HOME}/.env_paths" ]] && \. "${HOME}/.env_paths"

# prevent a massive spawn of ssh-agent agents
ssh-add -l &>/dev/null
if [ "$?" -ne 0 ]; then
    test -r ~/.ssh-agent && \
    eval "$(<~/.ssh-agent)" >/dev/null

    ssh-add -l &>/dev/null
    if [ "$?" -ne 0 ]; then
        (umask 066; ssh-agent > ~/.ssh-agent)
        eval "$(<~/.ssh-agent)" >/dev/null
        find ~/.ssh -type f -name id_rsa -exec ssh-add {} \;
    fi
fi

# set prompt_command
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# set PS1
export PS1='\[\033]0;\u@\h:\w\007\]\[\033[1;32m\]\n[ \w ]\n\[\033[1;39m\]\u@\h \[\033[1;31m\]>> \[\033[m\]'

# (conda) python development environment
[[ -f "${HOME}/conda/etc/profile.d/conda.sh" ]] && \. "${HOME}/conda/etc/profile.d/conda.sh"

alias java8="export JAVA_HOME=\"${JAVA_8_HOME}\""
alias java9="export JAVA_HOME=\"$JAVA_9_HOME\""

# default java version
export JAVA_HOME="${JAVA_8_HOME}"
export PATH="${JAVA_HOME}/bin:${PATH}"

# export git user
export GIT_AUTHOR_NAME="\"${GIT_AUTHOR_NAME}\""
export GIT_AUTHOR_EMAIL="\"${GIT_AUTHOR_EMAIL}\""

# npm/node config
if [[ -n "${NPM_PACKAGES_DIR}" ]]; then
    # if NPM_PACKAGES_DIR exists; export the path
    [[ ! -d "${NPM_PACKAGES_DIR}" ]] && mkdir -p "${NPM_PACKAGES_DIR}" || export PATH="${NPM_PACKAGES_DIR}/bin:${PATH}"

    # Unset manpath so we can inherit from /etc/manpath via the `manpath` command
    unset MANPATH # delete if you already modified MANPATH elsewhere in your config
    export MANPATH="$NPM_PACKAGES_DIR/share/man:$(manpath)"
fi

# nvm config
if [[ -n "${NVM_DIR}" ]]; then
    # if NVM_DIR exists; export NVM_DIR
    [[ ! -d "${NVM_DIR}" ]] && mkdir -p "${NVM_DIR}" || export NVM_DIR="${NVM_DIR}"
    [[ -s "${NVM_DIR}/nvm.sh" ]] && \. "${NVM_DIR}/nvm.sh"  # This lOads nvm
    [[ -s "${NVM_DIR}/bash_completion" ]] && \. "${NVM_DIR}/bash_completion"  # This loads nvm bash_completion
fi

# rvm config
if [[ -n "${RVM_DIR}" ]]; then
    # if RVM_DIR exists; export RVM_DIR
    [[ -s "${RVM_DIR}" ]] && mkdir -p "${RVM_DIR}" || export PATH="${RVM_DIR}/bin:${PATH}"
    [[ -s "${RVM_DIR}/scripts/rvm" ]] && \. "${RVM_DIR}/scripts/rvm"
fi

