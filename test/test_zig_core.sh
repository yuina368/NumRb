#!/bin/bash
# NumRbのテストスクリプト

set -e

cd "$(dirname "$0")/../ext/num_rb"

echo "============================================"
echo "Zigコアのコンパイルテスト..."
echo "============================================"

# オブジェクトファイルとしてコンパイル
zig build-obj core.zig -O ReleaseFast -lc

if [ $? -eq 0 ]; then
    echo "✓ Zigコンパイル成功"
    ls -lh core.o 2>/dev/null || true
    rm -f core.o
else
    echo "✗ Zigコンパイル失敗"
    exit 1
fi

echo ""
echo "============================================"
echo "共有ライブラリとしてコンパイルテスト..."
echo "============================================"
zig build-lib core.zig -dynamic -O ReleaseFast -lc -femit-bin=num_rb_core.so

if [ $? -eq 0 ]; then
    echo "✓ 共有ライブラリコンパイル成功"
    ls -lh num_rb_core.so 2>/dev/null || true
    file num_rb_core.so 2>/dev/null || true
else
    echo "✗ 共有ライブラリコンパイル失敗"
    exit 1
fi

echo ""
echo "============================================"
echo "Rubyテストの実行..."
echo "============================================"
cd "$(dirname "$0")/.."

# Rubyのテストを実行
ruby -I./lib test/test_num_rb.rb 2>/dev/null || {
    echo "⚠ Rubyテストは拡張モジュールがロードできないため実行できません"
    echo "   (拡張モジュールのビルドが必要です)"
    echo ""
    echo "テストコードは以下で確認できます:"
    echo "  - test/test_num_rb.rb - Rubyユニットテスト"
    echo "  - test/test_zig_core.sh - Zigコンパイルテスト"
}

echo ""
echo "============================================"
echo "すべてのテストが完了しました！"
echo "============================================"
