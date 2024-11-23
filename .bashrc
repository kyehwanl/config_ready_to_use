# Bourne Again SHell init file.
#
# Files you make look like rw-rw-r
umask 027

# Don't make useless coredump files.  If you want a coredump,
# say "ulimit -c unlimited" and then cause a segmentation fault.
ulimit -c 0

alias unsetenv=unset
function setenv () {
  export $1="$2"
}


#setenv DISPLAY :0.0
setenv LD_LIBRARY_PATH=/usr/local/lib
setenv NAME ''
setenv TROFF ptroff

PYCSCOPE_PATH=/users/kyehwanl/pycscope-0.3/build/scripts-2.5/
#RPKI_UTIL_PATH=/users/kyehwanl/subvert-rpki.hactrn.net/utils
PATH=$JAVA_PATH/bin/:$OOP_PATH:$STANDARD_PATH:/opt/gnu/bin:/usr/sbin:/sbin:/usr/lib:/usr/X11R6/bin:$RPKI_UTIL_PATH:$PYCSCOPE_PATH
STANDARD_PATH=$LOCAL_PATH:$OPENWIN_PATH:$SYSTEM_PATH:$SUNLINK_PATH:$SPECIAL_PATH:$MOUNT_PATH:$TEMP_PATH:$MAN2_PATH:$JAVA_PATH


# If running interactively, then:
if [ "$PS1" ]; then
  ignoreeof=
  no_exit_on_failed_exec=
fi

prefix=`hostname | sed -e 's/\./-/' -e 's/\..*//' -e 's/-/\./'`
suffix="-> "

function set_prompt() {
  #PS1="$prefix [\!]{`dirs|sed -e 's| .*||' -e 's|.*[^/]\(/[^/]*/[^/]*\)|...\1|'`}$suffix" 
  #PS1="\[\e[01;32m\h\e[m\]\[\e[01;38m [\!]{`dirs|sed -e 's| .*||' -e 's|.*[^/]\(/[^/]*/[^/]*\)|...\1|'`}\e[m\]\$ "
  PS1="\[\033[01;32m\]\h\[\033[00m\]\[\033[01;38m\] [\!]{`dirs|sed -e 's| .*||' -e 's|.*[^/]\(/[^/]*/[^/]*\)|...\1|'`}\[\033[00m\]\$ "
}

PROMPT_COMMAND=set_prompt
HISTSIZE=2000
HISTFILE=~/.history
#HISTFILESIZE=50
export HISTCONTROL=ignoredups
export HISTIGNORE="pwd:ls:ls -htrl:ll"

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

# --- Original color setting
#LS_COLORS='di=01;34:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.tbz=01;31:*.tbz2=01;31:*.bz=01;31:*.tz=01;31'

#LS_COLORS='di=38;5;27:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.tbz=01;31:*.tbz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.c=33:*Makefile=95:*.am=35:*.o=90:*.ac=96:*.h=90'
#LS_COLORS+='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.tbz=01;31:*.tbz2=01;31:*.bz=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=01;36:*.au=01;36:*.flac=01;36:*.mid=01;36:*.midi=01;36:*.mka=01;36:*.mp3=01;36:*.mpc=01;36:*.ogg=01;36:*.ra=01;36:*.wav=01;36:*.axa=01;36:*.oga=01;36:*.spx=01;36:*.xspf=01;36:'
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'

#use 'ctrl shit -' to replace 'ctrl s'
#stty stop  


#export TERM=xterm-256color   # without this setting, shell file coloring becomes weird
export TERM=screen-256color
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/users/kyehwanl/Download/libevent-2.0.21-stable/_inst/usr/local/lib"
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.181-3.b13.el7_5.x86_64/jre

if [ -f ~/.go ]; then
    source ~/.go
fi


docker-ip() {
  sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"
}

# Created by `userpath` on 2021-10-25 04:45:30
export PATH="$PATH:$USER/.local/bin"

# --- Kubernetes Setting ----
if [ -f ~/.kubectl_bash_completion ]; then
  if command -v kubectl &> /dev/null
  then
    source ~/.kubectl_bash_completion
  fi
fi
#export KUBECONFIG=$HOME/.kube/config2
#source /etc/profile.d/bash_completion.sh
#source <(kubectl completion bash)
#alias k=kubectl
#source <(kubectl completion bash | sed s/kubectl/k/g)

##########################################################
# --------- ble.sh (Bash Line Editor) -------------------
# https://github.com/akinomyoga/ble.sh.git
##########################################################
# ble.sh -- Bash Line Editor
if [ -f ~/.local/share/blesh/ble.sh ]; then
  source ~/.local/share/blesh/ble.sh

  # Favoriate fg color without background
  ble-face auto_complete=fg=241
  #ble-face auto_complete=fg=238,bg=254 # <-- default

  # Disable EOF marker like "[ble: EOF]"
  bleopt prompt_eol_mark=''
  # Disable error exit marker like "[ble: exit %d]"
  bleopt exec_errexit_mark=
  # Disable exit marker like "[ble: exit]"
  bleopt exec_exit_mark=
  # Disable some other markers like "[ble: ...]"
  bleopt edit_marker=
  bleopt edit_marker_error=
fi


###########################################################
# kubecolor
# https://github.com/hidetatz/kubecolor?tab=readme-ov-file
#       wget https://github.com/hidetatz/kubecolor/releases/download/v0.0.25/kubecolor_0.0.25_Linux_x86_64.tar.gz
#       tar zxvf kubecolor_0.0.25_Linux_x86_64.tar.gz kubecolor
#       sudo cp kubecolor /usr/bin/ (or sudo install kubecolor /usr/local/bin or  just copy into ~/Download/)
###########################################################
# kubecolor
command -v kubecolor >/dev/null 2>&1 && alias kubectl="kubecolor"





