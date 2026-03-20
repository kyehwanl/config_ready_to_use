#!/bin/bash -x

# 1. gotags 생성 (Go 전용)
find $PWD -name '*.go' | gotags -f gotags -R -L -

# 2. cscope 생성 (Go, C, H 포함 문맥 추적)
find $PWD -type f \( -name '*.go' -o -name '*.c' -o -name '*.h' \) > cscope.files
cscope -bvq

# 3. universal-ctags 생성 (C 언어 및 범용 태그용)
# brew install universal-ctags
ctags -R --exclude=.git --exclude=vendor .
