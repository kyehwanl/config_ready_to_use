#!/bin/bash -x
tar cvfz _.vim_2023_.tar.gz --exclude="plugins.tar.gz" --exclude=".git" .vim

# github donwload 
# wget https://github.com/kyehwanl/config_ready_to_use/raw/master/_.vim_2023_0203.tar.gz

# COPYFILE_DISABLE : disable Mac metadata when using tar
COPYFILE_DISABLE=1 tar cvfz _.vim_2026_0323_.tar.gz  --exclude=".git" --exclude="*bundle/coc.nvim*" --exclude=".vim/bundle/python-mode" .vim
