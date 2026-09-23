#!/bin/bash

# 기본값: 테스트 파일 제외
INCLUDE_TESTS=false

# -t 옵션 파싱
while getopts "t" opt; do
  case $opt in
    t) INCLUDE_TESTS=true ;;
    \?) echo "Usage: $0 [-t]" >&2; exit 1 ;;
  esac
done

echo "Generating tags... (Include _test.go: $INCLUDE_TESTS)"

if [ "$INCLUDE_TESTS" = true ]; then
	# 1. gotags 생성 (Go 전용)
    find "$PWD" -type f -name '*.go' | gotags -f gotags -L -
    
	# 2. cscope 생성 (Go, C, H 포함 문맥 추적)
    find "$PWD" -type f \( -name '*.go' -o -name '*.c' -o -name '*.h' \) > cscope.files
    
	# 3. universal-ctags 생성 (C 언어 및 범용 태그용)
	#  (NEED: brew install universal-ctags )
    ctags -R --exclude=.git --exclude=vendor .
else
    # 1. gotags (_test.go 제외)
    find "$PWD" -type f -name '*.go' ! -name '*_test.go' | gotags -f gotags -L -
    
    # 2. cscope (_test.go 제외)
    find "$PWD" -type f \( \( -name '*.go' ! -name '*_test.go' \) -o -name '*.c' -o -name '*.h' \) > cscope.files
    
    # 3. ctags (_test.go 제외)
    ctags -R --exclude=.git --exclude=vendor --exclude='*_test.go' .
fi

cscope -bvq
echo "Done!"
