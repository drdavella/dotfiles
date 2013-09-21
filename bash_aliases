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
alias docs='cd /home/dan/Documents '
alias downs='cd /home/dan/Downloads '
alias books='cd /home/dan/E-Books '
alias media='cd /media/dan/banjoCase '
alias addalias='vim /home/dan/.bash_aliases '
alias bashrc='vim /home/dan/.bashrc '
alias vimrc='vim ~/.vimrc'
alias tmuxrc='vim ~/.tmux.conf'
alias pyrc='vim /home/dan/.pythonrc '
alias src='source /home/dan/.bashrc '
alias cll='clear; ll'
alias ff='firefox '
alias g='gedit '
alias n='nedit '
alias e='evince '
alias chrome='chromium-browswer'
alias algs='cd ~/COURSES/Algorithms'
alias webd='cd ~/COURSES/Web_development'
alias netw='cd ~/COURSES/Networking'

### jars
alias mars='java -jar ~/jars/Mars4_3.jar '

### books
alias stats='e ~/E-Books/thinkstats.pdf '
alias nltk='e ~/E-Books/NLP_Toolkit/nltk.pdf '
alias complexity='e ~/E-Books/thinkcomplexity.pdf '

#### hashing
alias md5='openssl md5 '
alias sha1='openssl sha1 '

#### network stuff
alias ports='netstat -tulanp '
alias ipconfig='ifconfig '

#### git stuff
alias branch='git branch'
alias add='git add'
alias log='git log'
alias commit='git commit'

#### WINE stuff
alias tabledit='wine ~/.wine/drive_c/Program\ Files\ \(x86\)/TablEdit/tabledit.exe'
