#!/bin/bash
set -e

# 인자가 전달되었는지 확인 (예: JIT.cpp를 빌드하고 싶다면 'JIT'만 입력)
if [ -z "$1" ]; then
    echo "사용법: ./JIT.sh <프로그램이름(확장자 제외)>"
    echo "예시: ./JIT.sh JIT"
    exit 1
fi

TARGET=$1
CPP_FILE="${TARGET}.cpp"
OUTPUT_FILE="${TARGET}_app"

# 파일이 실제로 존재하는지 체크
if [ ! -f "$CPP_FILE" ]; then
    echo "에러: '$CPP_FILE' 파일을 찾을 수 없습니다!"
    exit 1
fi

echo "=== [$TARGET] 최적화 빌드 시작 (-Ofast, -march=native, -flto) ==="

# C++ 컴파일
g++ -std=c++17 -Ofast -march=native -flto "$CPP_FILE" -o "$OUTPUT_FILE"

echo "=== 빌드 완료! './$OUTPUT_FILE' 실행 ==="
echo "----------------------------------------"

# 빌드된 프로그램 실행
./"$OUTPUT_FILE"
