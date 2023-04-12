if [ -f ~/.bashrc ]; then
	\. ~/.bashrc
fi

# Wheneth running macOS; breweth
[[ "$(uname)" == "Darwin" ]] &&  eval "$(/opt/homebrew/bin/brew shellenv)"

