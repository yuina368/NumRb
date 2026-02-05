require 'benchmark'
require_relative '../lib/num_rb'

# NArrayのインストール確認
begin
  require 'narray'
  NARRAY_AVAILABLE = true
rescue LoadError
  NARRAY_AVAILABLE = false
  puts "警告: NArrayがインストールされていません（gem install narray でインストール可能）"
  puts
end

# Numoのインストール確認
begin
  require 'numo/narray'
  NUMO_AVAILABLE = true
rescue LoadError
  NUMO_AVAILABLE = false
  puts "警告: Numo::NArrayがインストールされていません（gem install numo-narray でインストール可能）"
  puts
end

def benchmark_all_libraries
  sizes = [1000, 10000, 100000]
  
  puts "=" * 80
  puts "NumRb vs 他のライブラリ - パフォーマンス比較"
  puts "=" * 80
  puts
  
  sizes.each do |size|
    puts "配列サイズ: #{size}"
    puts "-" * 80
    
    # データの準備
    arr1 = Array.new(size) { rand }
    arr2 = Array.new(size) { rand }
    
    ### 要素ごとの加算 ###
    puts "\n【要素ごとの加算】"
    
    # Ruby標準
    ruby_time = Benchmark.measure do
      result = arr1.zip(arr2).map { |a, b| a + b }
    end
    puts "  Ruby標準:          #{(ruby_time.real * 1000).round(3)} ms"
    
    # NumRb
    numrb_time = Benchmark.measure do
      result = NumRb.array_add(arr1, arr2)
    end
    puts "  NumRb:             #{(numrb_time.real * 1000).round(3)} ms  [#{(ruby_time.real / numrb_time.real).round(2)}x]"
    
    # NArray
    if NARRAY_AVAILABLE
      narr1 = NArray.to_na(arr1)
      narr2 = NArray.to_na(arr2)
      narray_time = Benchmark.measure do
        result = narr1 + narr2
      end
      puts "  NArray:            #{(narray_time.real * 1000).round(3)} ms  [#{(ruby_time.real / narray_time.real).round(2)}x]"
    end
    
    # Numo::NArray
    if NUMO_AVAILABLE
      numo1 = Numo::DFloat.cast(arr1)
      numo2 = Numo::DFloat.cast(arr2)
      numo_time = Benchmark.measure do
        result = numo1 + numo2
      end
      puts "  Numo::NArray:      #{(numo_time.real * 1000).round(3)} ms  [#{(ruby_time.real / numo_time.real).round(2)}x]"
    end
    
    ### 要素ごとの乗算 ###
    puts "\n【要素ごとの乗算】"
    
    # Ruby標準
    ruby_mult_time = Benchmark.measure do
      result = arr1.zip(arr2).map { |a, b| a * b }
    end
    puts "  Ruby標準:          #{(ruby_mult_time.real * 1000).round(3)} ms"
    
    # NumRb
    numrb_mult_time = Benchmark.measure do
      result = NumRb.array_multiply(arr1, arr2)
    end
    puts "  NumRb:             #{(numrb_mult_time.real * 1000).round(3)} ms  [#{(ruby_mult_time.real / numrb_mult_time.real).round(2)}x]"
    
    # NArray
    if NARRAY_AVAILABLE
      narray_mult_time = Benchmark.measure do
        result = narr1 * narr2
      end
      puts "  NArray:            #{(narray_mult_time.real * 1000).round(3)} ms  [#{(ruby_mult_time.real / narray_mult_time.real).round(2)}x]"
    end
    
    # Numo::NArray
    if NUMO_AVAILABLE
      numo_mult_time = Benchmark.measure do
        result = numo1 * numo2
      end
      puts "  Numo::NArray:      #{(numo_mult_time.real * 1000).round(3)} ms  [#{(ruby_mult_time.real / numo_mult_time.real).round(2)}x]"
    end
    
    ### 合計 ###
    puts "\n【合計】"
    
    # Ruby標準
    ruby_sum_time = Benchmark.measure do
      sum = arr1.sum
    end
    puts "  Ruby標準:          #{(ruby_sum_time.real * 1000).round(3)} ms"
    
    # NumRb
    numrb_sum_time = Benchmark.measure do
      sum = NumRb.array_sum(arr1)
    end
    puts "  NumRb:             #{(numrb_sum_time.real * 1000).round(3)} ms  [#{(ruby_sum_time.real / numrb_sum_time.real).round(2)}x]"
    
    # NArray
    if NARRAY_AVAILABLE
      narray_sum_time = Benchmark.measure do
        sum = narr1.sum
      end
      puts "  NArray:            #{(narray_sum_time.real * 1000).round(3)} ms  [#{(ruby_sum_time.real / narray_sum_time.real).round(2)}x]"
    end
    
    # Numo::NArray
    if NUMO_AVAILABLE
      numo_sum_time = Benchmark.measure do
        sum = numo1.sum
      end
      puts "  Numo::NArray:      #{(numo_sum_time.real * 1000).round(3)} ms  [#{(ruby_sum_time.real / numo_sum_time.real).round(2)}x]"
    end
    
    puts "\n" + "=" * 80
    puts
  end
  
  puts "\n【まとめ】"
  puts "- NumRb: Zigベースの軽量・高速数値演算ライブラリ"
  if NARRAY_AVAILABLE
    puts "- NArray: 昔からあるRuby数値計算ライブラリ"
  else
    puts "- NArray: 未インストール（gem install narray）"
  end
  if NUMO_AVAILABLE
    puts "- Numo::NArray: NArrayの後継、最も最適化されたライブラリ"
  else
    puts "- Numo::NArray: 未インストール（gem install numo-narray）"
  end
  puts
end

if __FILE__ == $0
  benchmark_all_libraries
end
