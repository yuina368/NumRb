#!/bin/bash
# Zigコアのテストスクリプト

cd "$(dirname "$0")/../ext/num_rb"

echo "Zigコアのコンパイルテスト..."
echo "================================"

# オブジェクトファイルとしてコンパイル
zig build-obj core.zig -O ReleaseFast -lc

if [ $? -eq 0 ]; then
    echo "✓ Zigコンパイル成功"
    ls -lh core.o
    rm -f core.o
else
    echo "✗ Zigコンパイル失敗"
    exit 1
fi

echo ""
echo "共有ライブラリとしてコンパイルテスト..."
zig build-lib core.zig -dynamic -O ReleaseFast -lc -femit-bin=num_rb_core.so

if [ $? -eq 0 ]; then
    echo "✓ 共有ライブラリコンパイル成功"
    ls -lh num_rb_core.so
    file num_rb_core.so
else
    echo "✗ 共有ライブラリコンパイル失敗"
    exit 1
fi

echo ""
echo "すべてのテストが成功しました！"
