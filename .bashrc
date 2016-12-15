# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
# Set PATH
export PATH=/usr/local/bin:$PATH
# set architecture flags
#export ARCHFLAGS="-arch x86_64"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Python Development Environment
export WORKON_HOME=$HOME/code/.virtualenvs
export PIP_REQUIRE_VIRTUALENV=true
export PROJECT_HOME=$HOME/code
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
mkdir -p $WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh 

gpip () {
	PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

# Java Development Environment
export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
export JAVA_7_HOME=$(/usr/libexec/java_home -v1.7)

alias java7="export JAVA_HOME=$JAVA_7_HOME"
alias java8="export JAVA_HOME=$JAVA_8_HOME"

# default java version
export JAVA_HOME=$JAVA_8_HOME

#set_brightness () {
#	if [ -z "$1" ]; then
#		BRIGHTNESS=0;
#	else
#		BRIGHTNESS=$1;
#	fi
#	/usr/bin/sudo /bin/bash -c "echo $BRIGHTNESS > /sys/class/backlight/intel_backlight/brightness"
#} 

# User specific aliases and functions
alias ll='ls -l'
