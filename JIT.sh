#!/bin/bash
set -e

if [ -z "$1" ]; then
    echo "사용법: ./JIT.sh <프로그램이름(확장자 제외)>"
    echo "예시: ./JIT.sh JIT"
    exit 1
fi

TARGET=$1
CPP_FILE="${TARGET}.cpp"
OUTPUT_FILE="${TARGET}_app"

if [ ! -f "$CPP_FILE" ]; then
    echo "에러: '$CPP_FILE' 파일을 찾을 수 없습니다!"
    exit 1
fi

echo "=== [$TARGET] 최적화 빌드 시작 (-Ofast, -march=native, -flto) ==="

g++ -std=c++17 -Ofast -march=native -flto "$CPP_FILE" -o "$OUTPUT_FILE"

echo "=== 빌드 완료! './$OUTPUT_FILE' 실행 ==="
echo "----------------------------------------"

./"$OUTPUT_FILE"
