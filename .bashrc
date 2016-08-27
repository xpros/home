# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
export WORKON_HOME=$HOME/code/.virtualenvs
export PIP_REQUIRE_VIRTUALENV=true
export PROJECT_HOME=$HOME/code
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
mkdir -p $WORKON_HOME
source /usr/bin/virtualenvwrapper.sh 

gpip () {
	PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

set_brightness () {
	if [ -z "$1" ]; then
		BRIGHTNESS=0;
	else
		BRIGHTNESS=$1;
	fi
	/usr/bin/sudo /bin/bash -c "echo $BRIGHTNESS > /sys/class/backlight/intel_backlight/brightness"
} 

# User specific aliases and functions
