#======================================
#
#  ALIASES AND FUNCTIONS
#
#======================================
# Source global definitions (if any)
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# source local definitions (if any)
if [ -f .localrc ]; then
	. .localrc
fi

export TERM=xterm
set -o vi

# display version info
#echo "You are running BASH $BASH_VERSION";
#last -n 20
#------------------
# Aliases
#------------------
alias rm='rm -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias giddit='git pull'
alias pushit='git push'
alias lsa='ls -halt'
alias burp='java -jar -Xmx1024m ~/scripts/burpsuite_free_v1.6.jar'
alias fireburp='~/local/firefox/firefox'

# random art and fortune upon login
#command fortune -a | fmt -80 -s | $(shuf -n 1 -e cowsay cowthink) -$(shuf -n 1 -e b d g p s t w y) -f $(shuf -n 1 -e $(cowsay -l | tail -n +2)) -n

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



wprepd() {

	if [[ "$#" -ne 1 ]]; then
		echo "prep-devel takes exactly 1 argument"
		return;
	fi
	
	webdir=$1;
	if [[ -z "$webdir" ]]; then
		echo "Please enter directory as the argument."
		return;
	fi

	if ! [[ -d "$webdir" ]]; then
		echo "That's not a fucking directory, numnuts."
		return;
	fi

	chown apache:studsys "$webdir";
	chmod 775 "$webdir";
	cd "$webdir";
	find . -print0 | xargs -0 chown apache:studsys
	find . -type f -print0 | xargs -0 chmod 664
	find . -type d -print0 | xargs -0 chmod 775

	# if a .git directory exists, we need to use slightly different permissions
	if [[ -d ".git" ]]; then
		chown "($whoami):studsys" ".git";
		cd ".git";
		find . -print0 | xargs -0 chown "$(whoami):studsys"
		cd ..
	fi
	
	cd ..
	
}

wprepp() {

	if [[ "$#" -ne 1 ]]; then
		echo "prep-devel takes exactly 1 argument"
		return;
	fi
	
	webdir=$1;
	if [[ -z "$webdir" ]]; then
		echo "Please enter directory as the argument."
		return;
	fi

	if ! [[ -d "$webdir" ]]; then
		echo "That's not a fucking directory, numnuts."
		return;
	fi

	chown apache:studsys "$webdir";
	chmod 755 "$webdir";
	cd "$webdir";
	find . -print0 | xargs -0 chown apache:studsys
	find . -type f -print0 | xargs -0 chmod 644
	find . -type d -print0 | xargs -0 chmod 755

	# if a .git directory exists, we need to use slightly different permissions
	if [[ -d ".git" ]]; then
		rm -rf ".git";
	fi
	
	cd ..
	
}



# ------- BEGIN DOTIFY --------------------------------------------------------

function dotify {

	echo "Hi there $(whoami)!"
	echo -n "Please enter your github user name and press [ENTER]: "
	read dgit_user
	echo "Great! Now enter the name of the git repo where you keep your\
			 dotfiles."
	echo -n "Please enter name of dotfiles repo and press [ENTER]: "
	read dgit_repo
	echo

	for host in "$@"; do

		ssh -t "$(whoami)@$host" "rm -rf labrynth && \
			git clone git@github.com:jgr68/labrynth && \
			mv labrynth/dotfile-payload.sh . && rm -rf labrynth && \
			./dotfile-payload.sh -r $dgit_repo -g $dgit_user && \
			yes | rm ~/dotfile-payload.sh"

	done	
}

# ------- END DOTIFY ----------------------------------------------------------



