require 'benchmark'
require_relative '../lib/num_rb'

def benchmark_comparisons
  sizes = [100, 1000, 10000, 100000]
  
  puts "=" * 70
  puts "NumRb Performance Benchmark"
  puts "=" * 70
  puts
  
  sizes.each do |size|
    puts "Array size: #{size}"
    puts "-" * 70
    
    # データの準備
    arr1 = Array.new(size) { rand }
    arr2 = Array.new(size) { rand }
    
    # Ruby標準の配列演算
    ruby_time = Benchmark.measure do
      result = arr1.zip(arr2).map { |a, b| a + b }
    end
    
    # NumRbの配列演算
    numrb_time = Benchmark.measure do
      result = NumRb.array_add(arr1, arr2)
    end
    
    puts "Ruby標準の加算:     #{ruby_time.real.round(6)} sec"
    puts "NumRb の加算:       #{numrb_time.real.round(6)} sec"
    puts "速度比: #{(ruby_time.real / numrb_time.real).round(2)}x faster"
    puts
    
    # 乗算のベンチマーク
    ruby_mult_time = Benchmark.measure do
      result = arr1.zip(arr2).map { |a, b| a * b }
    end
    
    numrb_mult_time = Benchmark.measure do
      result = NumRb.array_multiply(arr1, arr2)
    end
    
    puts "Ruby標準の乗算:     #{ruby_mult_time.real.round(6)} sec"
    puts "NumRb の乗算:       #{numrb_mult_time.real.round(6)} sec"
    puts "速度比: #{(ruby_mult_time.real / numrb_mult_time.real).round(2)}x faster"
    puts
    
    # 合計のベンチマーク
    ruby_sum_time = Benchmark.measure do
      sum = arr1.sum
    end
    
    numrb_sum_time = Benchmark.measure do
      sum = NumRb.array_sum(arr1)
    end
    
    puts "Ruby標準の合計:     #{ruby_sum_time.real.round(6)} sec"
    puts "NumRb の合計:       #{numrb_sum_time.real.round(6)} sec"
    puts "速度比: #{(ruby_sum_time.real / numrb_sum_time.real).round(2)}x faster"
    puts
    puts "=" * 70
    puts
  end
end

# クラスインターフェースのテスト
def test_class_interface
  puts "NumRb::Array クラスインターフェースのテスト"
  puts "=" * 70
  
  a = NumRb::Array.new([1.0, 2.0, 3.0, 4.0, 5.0])
  b = NumRb::Array.new([2.0, 3.0, 4.0, 5.0, 6.0])
  
  puts "配列 a: #{a.inspect}"
  puts "配列 b: #{b.inspect}"
  puts
  
  c = a + b
  puts "a + b = #{c.inspect}"
  
  d = a * b
  puts "a * b = #{d.inspect}"
  
  puts "a.sum  = #{a.sum}"
  puts "a.mean = #{a.mean}"
  puts
end

if __FILE__ == $0
  test_class_interface
  benchmark_comparisons
end
