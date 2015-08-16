#############################
###
### PERSONAL BASH ALIASES
###
############################

### use vi edit mode in shell
set -o vi

#### saftey aliases
alias rm='/bin/rm -i'
alias mv='/bin/mv -i'
alias cp='/bin/cp -i'

##### directory navigation
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias home='cd'

##### directory listing
alias ll='ls -l'
alias la='ls -la'

#### colordiff
alias diff='colordiff '

#### colorize grep
alias grep='grep --color=auto '
alias egrep='egrep --color=auto '
alias fgrep='fgrep --color=auto '

#### for convenience
alias docs='cd $HOME/Documents '
alias downs='cd $HOME/Downloads '
alias books='cd $HOME/E-Books '
alias media='cd /media/dan/banjoCase '
alias addalias='vim $HOME/.bash_aliases '
alias bashrc='vim $HOME/.bashrc '
alias vimrc='vim ~/.vimrc'
alias tmuxrc='vim ~/.tmux.conf'
alias pyrc='vim $HOME/.pythonrc '
alias src='source $HOME/.bashrc '
alias cll='clear; ll'
alias ff='firefox '
alias g='gedit 2>/dev/null'
alias n='nedit '
alias e='evince '
alias chrome='chromium-browser'
alias firefox='firefox 1>/dev/null 2>/dev/null'
alias kile='kile 2>/dev/null'
alias which='type -f'
alias maven='mvn'
alias eclipse='/opt/eclipse/eclipse'

# courses
alias algs='cd ~/COURSES/Algorithms'
alias webd='cd ~/COURSES/Web_development'
alias netw='cd ~/COURSES/Networking'
alias nwp='cd ~/COURSES/Network_programming'
alias mpa='cd ~/COURSES/Multiprocessor_architecture'
alias nlp='cd ~/COURSES/NLP'

### jars
alias mars='java -jar ~/jars/Mars4_3.jar '

### books
alias stats='e ~/E-Books/thinkstats.pdf '
alias nltk='e ~/E-Books/NLP_Toolkit/nltk.pdf '
alias complexity='e ~/E-Books/thinkcomplexity.pdf '

### python
alias ipython='/usr/bin/ipython3'
alias ipython2='/usr/bin/ipython'
alias python='/usr/bin/python3'
alias python2='/usr/bin/python'

#### hashing
alias md5='openssl md5 '
alias sha1='openssl sha1 '

#### network stuff
alias ports='netstat -tulanp '
alias ipconfig='ifconfig '

#### network programming class
alias ptux='ssh ddavell1@ptux.apl.jhu.edu'
alias dev4='ssh ddavell1@dev4.apl.jhu.edu'

#### git stuff
alias branch='git branch'
alias add='git add'
alias log='git log'
alias commit='git commit'
alias checkout='git checkout'

#### WINE stuff
alias tabledit='wine ~/.wine/drive_c/Program\ Files\ \(x86\)/TablEdit/tabledit.exe'
