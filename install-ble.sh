#!/bin/bash -x

command -v git  >/dev/null 2>&1 || sudo apt install -y git
command -v make >/dev/null 2>&1 || sudo apt install -y make

if [ ! -f "~/.local/share/blesh/ble.sh" ]; then
  echo "--- ble.sh install ---"
  git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
  make -C ble.sh install PREFIX=~/.local >/dev/null
  #echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bashrc

  echo ""                                                     >> ${HOME}/.bashrc 
  echo "# ------ ble.sh (Bash Line Editor) ----------------"  >> ${HOME}/.bashrc 
  echo "if [ -f ~/.local/share/blesh/ble.sh ]; then"          >> ${HOME}/.bashrc
  echo "  source ~/.local/share/blesh/ble.sh"                 >> ${HOME}/.bashrc

  echo "  # Favoriate fg color without background"            >> ${HOME}/.bashrc
  echo "  ble-face auto_complete=fg=241"                      >> ${HOME}/.bashrc
  echo "  #ble-face auto_complete=fg=238,bg=254 # <--default" >> ${HOME}/.bashrc

  echo '  # Disable EOF marker like "[ble: EOF]"'             >> ${HOME}/.bashrc
  echo "  bleopt prompt_eol_mark=''  "                        >> ${HOME}/.bashrc
  echo '  # Disable error exit marker like "[ble: exit %d]"'  >> ${HOME}/.bashrc
  echo "  bleopt exec_errexit_mark="                          >> ${HOME}/.bashrc
  echo '  # Disable exit marker like "[ble: exit]"'           >> ${HOME}/.bashrc
  echo "  bleopt exec_exit_mark="                             >> ${HOME}/.bashrc
  echo '  # Disable some other markers like "[ble: ...]"'     >> ${HOME}/.bashrc
  echo "  bleopt edit_marker="                                >> ${HOME}/.bashrc
  echo "  bleopt edit_marker_error="                          >> ${HOME}/.bashrc
  echo "fi"                                                   >> ${HOME}/.bashrc


  echo "--- need to source ble.sh/out/ble.sh"
  echo "--- need to source .bashrc and/or .bash_aliases"
fi
