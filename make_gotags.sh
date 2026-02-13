#!/bin/bash -x
find $PWD -name '*.go' | gotags -f gotags -R -L -
#find $PWD -name '*.go' > cscope.files
find $PWD -type f \( -name '*.go' -o -name '*.c' -o -name '*.h' \) > cscope.files
cscope -bvq
