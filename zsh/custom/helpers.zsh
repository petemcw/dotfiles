# Find current local IP address
function local_ips {
  ifconfig | grep "inet " | awk '{ print $2 }'
}

# Check if a domain is down
function down4me() {
  curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g'
}

# Find current remote IP address
function myip {
  res=$(curl -s ifconfig.me)
  echo -e "Your public IP is: ${echo_bold_green} $res ${echo_normal}"
}

# Generate random password
pass() {
  which gshuf &> /dev/null
  if [ $? -eq 1 ]
  then
    echo "Error: shuf isn't installed!"
    return 1
  fi

  pass=$(shuf -n4 /usr/share/dict/words | tr '\n' ' ')
  echo "With spaces (easier to memorize): $pass"
  echo "Without (use this as the pass): $(echo $pass | tr -d ' ')"
}

# Make a directory and immediately 'cd' into it
function mkcd() {
  mkdir -p "$*"
  cd "$*"
}

# Search through directory contents with grep
function lsgrep(){
  ls | grep "$*"
}

# Disk usage per directory
#   - Mac OS X and Linux
function usage() {
    if [ $(uname) = "Darwin" ]; then
        if [ -n $1 ]; then
            du -hd $1
        else
            du -hd 1
        fi

    elif [ $(uname) = "Linux" ]; then
        if [ -n $1 ]; then
            du -h --max-depth=1 $1
        else
            du -h --max-depth=1
        fi
    fi
}

# Back up file with timestamp
#   - useful for administrators and configs
function bak() {
    filename=$1
    filetime=$(date +%Y%m%d-%H%M%S)
    cp ${filename} ${filename}.${filetime}
}
