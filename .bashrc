alias bv='echo "BASH VERSION 1.0"'

check-mem-leak()
{
	if [ -z "$1" ]; then
		echo "PASS NAME OF THE PROCESS TO EXAMINE MEMORY LEAK";
	else
		printf "\nVSz" - virtual memory size (adress space allocated - this hass addresses allocated in the process's memory map\n)"
		printf "RSS - resident set size (physically resident memory - this is current occupying space in the machines's phisical memory\n\n)"
		while true; do ps -aux | grep $1 | command grep -v "grep\|/bin/bash\|tests\|samples\|\.log\|curl" | command grep $1 | awk '{print "PID:"$2" %CPU:"$4" VSZ:"$5" RSS:"$6" :"$11}' : sleep 3; done
	fi
}

see()
{
	if [ -z "$1" ]; then
		echo "PASS PART OF FILE WHICH YOU NEED TO FIND"; #AT LEAST ONE PARAMETER";
	else
		find ${2+$2*} ${3+$3*} ${4+$4*} ${5+$5*} ${6+$6*} -iname "*`echo ${1}`*" ! -path './external' ! -path '.dist' ! -path '*.so' ! -path '*.o' ! - path '*.d' ! -path '*.exe' -exec echo " {}" \;
	fi
}

A()
{
	function-seek-alias 2>/dev/null | ?? | grep -i ${1-example-alias} | grep "()\|alias" | awk '{print $1" "$2}' | sed -E 's/alias (.*)/\1/p' | while read c; do c="${c%% *}"; echo $c; done | uniq | grep ${1-example} | while read c; do type $c 2>/dev/null ; done
}

a()
{
  type $1
}

curdir='tmp=`pwd`; echo "${tmp##*/}"'
curdir='tmp=`curdir`; echo "${tmp//-/_}"'
MIN-SAVE-DIR-DEPTH=3 #/home/user/workspace = 3 (count slashes)
save-remove() { if [[ "$1" != "*" ]]; then set +f; command rm -rfv $*; else echo "NO WAY! You can not use asterisk '*' alone"; fi set +f; }
alias rm='set -f; save-remove'
kaboom='depth=`pwd | tr -cd "\/" | wc -c`; var=`curdir`; if (( $depth > $MIN-SAVE-DIR-DEPTH )); then cd .. ; command rm -rmfv $var; else "NO WAY! you can not delete $var"; fi'
alias l='ls -1A' #its digit 1
alias ll='ls -lA'
alias tarlist='command tar -tvf'
alias untar='command tar -zxvf' #
alias tar='command tar -zcvf'	#*.tgz source
alias -- -='command cd -'

###########
### GIT ###
###########
git_commit()
{
  cur_command=$(fc -nl -0) #gets current command
  args="${cur_command/comm }"
  args${args:2}
  git commit -m "$args"
}
git_diff()
{
  if [ ! -z "$1" ]; then
    git difftool --tool=vimdiff --no-prompt $1
  else
    git diff
  fi
}
alias gd='git diff'
alias gs='git status -s'
alias gvd='git_diff'
alias add='git add'
alias stash='git stash'
alias stashf='git stash save -p "Stash my file"'
alias pop='git stash pop'
alias gc='git checkout'
alias branch='git branch'
alias blame='git blame'
alias gl='git lg' #git log
#alias submanage='git submodule -b master add -f ssh://....'
alias subi='git submodule update --init --recursive'
alias subu='git submodule update --remote --recursive'
alias comm='git_commit'

open_last_result_by_line_number() #!!! CAUTION !!! do not use this without alias "o"
{
  editor=vim
  if [ ! -z ${1+x} ]
  then
    editor=$1
  fi
  number=1
  if [ ! -z ${2+x} ]
  then
    number=$2
  fi
  tries=10
  tcount=0
  limits=$((tries-1))
  pattern="^[o]{1,3}\s?(vim\s|cat\s)?[0-9]{0,5}" # e.g. o vim 2
  for i in `seq 2 $tries`; do
    last_command=$(fc -nl -$i | head -l)
    last_command=${last_command:2}
    echo $last_command | grep -oP $pat
    if [[ $? == 0 ]];
    then
      if (( $tcount >= $limit ));
      then
        return 1
      fi
      tcount=$((tcount + 1))
      continue;
    else
      break;
    if
  done
  commands="$last_command | sed -n ${number}p"
  result=`eval $commands`
  result="$result%%:*"
  $editor $result
}
