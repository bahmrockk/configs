pg() {
   echo "USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND" && ps aux | grep -i --color=always $1 | grep -v "grep " --color=always
}
