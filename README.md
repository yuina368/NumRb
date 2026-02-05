# NumRb

Zigで書かれたRubyの数値演算ライブラリ。C拡張経由でRubyから呼び出すことで、標準のRuby配列演算を高速化します。

## 特徴

- **高速**: Ruby標準の配列演算と比較して5〜7倍の速度向上
- **軽量**: Zigの軽量なバイナリで、追加の依存ライブラリが不要
- **简单**: 使い慣れたRuby風のAPI

## ベンチマーク結果

### Ruby標準との比較（100,000要素配列）

| 操作 | Ruby標準 | NumRb | 高速化 |
|------|----------|-------|--------|
| 加算 | 19.3ms | 3.7ms | **5.2x faster** |
| 乗算 | 17.9ms | 3.4ms | **5.3x faster** |

### 他ライブラリとの比較（100,000要素）

| ライブラリ | 加算 | 乗算 |
|-----------|------|------|
| Ruby標準 | 基準 | 基準 |
| NumRb | 7.3x faster | 4.85x faster |
| NArray | 57.5x faster | 63.4x faster |
| Numo::NArray | 58.2x faster | 54.8x faster |

## インストール

### 要件

- Ruby 3.0以上
- Zig 0.11以上
- GCC/Clang（コンパイル用）

### インストール方法

```bash
git clone https://github.com/yuina368/NumRb.git
cd NumRb
cd ext/num_rb
ruby extconf.rb
make
cd ../..
```

## 使い方

### 基本的な配列演算

```ruby
require_relative 'ext/num_rb/num_rb'

# 配列の加算
NumRb.array_add([1.0, 2.0, 3.0], [4.0, 5.0, 6.0])
# => [5.0, 7.0, 9.0]

# 配列の乗算
NumRb.array_multiply([1.0, 2.0, 3.0], [4.0, 5.0, 6.0])
# => [4.0, 10.0, 18.0]

# 配列の合計
NumRb.array_sum([1.0, 2.0, 3.0, 4.0, 5.0])
# => 15.0

# 配列の平均
NumRb.array_mean([1.0, 2.0, 3.0, 4.0])
# => 2.5
```

### クラスインターフェース

```ruby
require_relative 'lib/num_rb'

# NumRb::Array クラスを使用
a = NumRb::Array.new([1.0, 2.0, 3.0, 4.0, 5.0])
b = NumRb::Array.new([2.0, 3.0, 4.0, 5.0, 6.0])

# 配列の演算
c = a + b  # => NumRb::Array[3.0, 5.0, 7.0, 9.0, 11.0]
d = a * b  # => NumRb::Array[2.0, 6.0, 12.0, 20.0, 30.0]

# 統計量
a.sum   # => 15.0
a.mean  # => 3.0
```

## APIリファレンス

### 関数

| 関数 | 説明 |
|------|------|
| `NumRb.add(a, b)` | 2つの数値を加算 |
| `NumRb.subtract(a, b)` | 2つの数値を減算 |
| `NumRb.multiply(a, b)` | 2つの数値を乗算 |
| `NumRb.divide(a, b)` | 2つの数値を除算（0除算時はNaNを返す） |
| `NumRb.array_add(arr1, arr2)` | 2つの配列を加算 |
| `NumRb.array_multiply(arr1, arr2)` | 2つの配列を乗算 |
| `NumRb.array_sum(arr)` | 配列の合計を計算 |
| `NumRb.array_mean(arr)` | 配列の平均を計算 |

## 開発

### テストの実行

```bash
ruby test/test_num_rb.rb
```

### ベンチマークの実行

```bash
ruby benchmark/benchmark.rb
```

### ライブラリ比較ベンチマーク

```bash
ruby benchmark/compare_libraries.rb
```

## 技術スタック

- **Zig 0.13**: 高速な数値演算コアの実装
- **Ruby C API**: Rubyとの連携インターフェース
- **C言語**: ブリッジ層

## ライセンス

MIT License

## 貢献

バグ報告やプルリクエスト，欢迎します！
