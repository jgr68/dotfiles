#======================================
#
#  ALIASES AND FUNCTIONS
#
#======================================
# Source global definitions (if any)
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export TERM=xterm
set -o vi

# display version info
echo "You are running BASH $BASH_VERSION";
last -n 20
#------------------
# Aliases
#------------------
alias rm='rm -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias giddit='git pull'
alias pushit='git push'
alias lsa='ls -halt'

# random art and fortune upon login
command fortune -a | fmt -80 -s | $(shuf -n 1 -e cowsay cowthink) -$(shuf -n 1 -e b d g p s t w y) -f $(shuf -n 1 -e $(cowsay -l | tail -n +2)) -n

# mock stuff
alias mock="mock -r ${USER}";

cl() {

	dir=$1
	if [[ -z "$dir" ]]; then
		dir=$HOME;
	fi
	if [[ -d "$dir" ]]; then
		cd "$dir";
		lsa;
	else
		echo "bash: cl: '$dir': Directory not found";
	fi
}

# set the ps1 to something awesome
PS1="[\u@\h \w]\n\$ ";

function dotify {

	for host in "$@"; do
		ssh -t "jgr68@$host" 'rm -rf labrynth && git clone git@github.com:jgr68/labrynth && mv labrynth/dotfile-payload.sh . && rm -rf labrynth && ./dotfile-payload.sh'
	done	
}
