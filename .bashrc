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
export PS1='\[\033]0;\u@\h:\w\a\]\[\033[1;32m\]\n[ \w ]\n\[\033[1;7;35m\]\u\[\033[0m\]@\[\033[1;7;35m\]\h\[\033[0m\] \D{%F %T} \[\033[0;31m\]\$ \[\033[0m\]'

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

# ansible config
if [[ -n "${ANSIBLE_DIR}" ]]; then
    # if ANSIBLE_DIR exists; export ANSIBLE_DIR
    [[ -s "${ANSIBLE_DIR}" ]] && mkdir -p "${ANSIBLE_DIR}" || export "${ANSIBLE_DIR}"
fi

