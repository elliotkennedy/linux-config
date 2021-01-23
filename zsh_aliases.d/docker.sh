alias dockerkillall='docker kill $(docker ps -q)'
alias dockerrmall='docker rm $(docker ps -aq)'
alias dockervolumekillall='docker volume rm $(docker volume ls -q)'

alias "dockerrmf"="dockerrmall && dockervolumekillall"
