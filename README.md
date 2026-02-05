# NumRb

ZigでRubyの数値演算を高速化するGem

## ベンチマーク結果（100,000要素配列）

| 操作 | Ruby標準 | NumRb | 高速化 |
|------|----------|-------|--------|
| 加算 | 65.8ms | 12.4ms | 5.3倍 |
| 乗算 | 65.0ms | 11.8ms | 5.5倍 |

## インストール

要件: Zig 0.11以上

\`\`\`bash
git clone https://github.com/yuina368/NumRb.git
cd NumRb/ext/num_rb
ruby extconf.rb
make
\`\`\`

## 使い方

\`\`\`ruby
require_relative 'ext/num_rb/num_rb'

NumRb.array_add([1.0, 2.0], [3.0, 4.0])  # => [4.0, 6.0]
NumRb.array_mean([1.0, 2.0, 3.0])        # => 2.0
\`\`\`

## 機能

- array_add, array_multiply: 要素ごと演算
- array_sum, array_mean: 統計量

## 技術スタック

- Zig 0.13 (高速演算コア)
- Ruby C API (インターフェース)
