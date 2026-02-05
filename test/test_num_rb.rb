require 'test/unit'
require_relative '../lib/num_rb'

class TestNumRb < Test::Unit::TestCase
  # 基本的な算術演算のテスト
  def test_add
    assert_equal(5.0, NumRb.add(2.0, 3.0))
    assert_equal(-1.0, NumRb.add(2.0, -3.0))
    assert_equal(0.0, NumRb.add(0.0, 0.0))
  end

  def test_subtract
    assert_equal(-1.0, NumRb.subtract(2.0, 3.0))
    assert_equal(5.0, NumRb.subtract(3.0, -2.0))
    assert_equal(0.0, NumRb.subtract(0.0, 0.0))
  end

  def test_multiply
    assert_equal(6.0, NumRb.multiply(2.0, 3.0))
    assert_equal(-6.0, NumRb.multiply(2.0, -3.0))
    assert_equal(0.0, NumRb.multiply(0.0, 5.0))
  end

  def test_divide
    assert_in_delta(2.0, NumRb.divide(6.0, 3.0), 0.0001)
    assert_in_delta(-2.0, NumRb.divide(6.0, -3.0), 0.0001)
  end

  def test_divide_by_zero
    result = NumRb.divide(5.0, 0.0)
    assert(result.nan?, "ゼロ除算はNaNを返すべき")
  end

  # 配列演算のテスト
  def test_array_add
    arr1 = [1.0, 2.0, 3.0, 4.0]
    arr2 = [5.0, 6.0, 7.0, 8.0]
    result = NumRb.array_add(arr1, arr2)
    assert_equal([6.0, 8.0, 10.0, 12.0], result)
  end

  def test_array_add_empty
    result = NumRb.array_add([], [])
    assert_equal([], result)
  end

  def test_array_multiply
    arr1 = [1.0, 2.0, 3.0, 4.0]
    arr2 = [5.0, 6.0, 7.0, 8.0]
    result = NumRb.array_multiply(arr1, arr2)
    assert_equal([5.0, 12.0, 21.0, 32.0], result)
  end

  def test_array_multiply_empty
    result = NumRb.array_multiply([], [])
    assert_equal([], result)
  end

  def test_array_sum
    arr = [1.0, 2.0, 3.0, 4.0, 5.0]
    assert_in_delta(15.0, NumRb.array_sum(arr), 0.0001)
  end

  def test_array_sum_empty
    assert_equal(0.0, NumRb.array_sum([]))
  end

  def test_array_mean
    arr = [1.0, 2.0, 3.0, 4.0]
    assert_in_delta(2.5, NumRb.array_mean(arr), 0.0001)
  end

  def test_array_mean_empty
    assert_equal(0.0, NumRb.array_mean([]))
  end

  # エラーハンドリングのテスト
  def test_array_length_mismatch
    arr1 = [1.0, 2.0, 3.0]
    arr2 = [4.0, 5.0]
    assert_raise(ArgumentError) { NumRb.array_add(arr1, arr2) }
    assert_raise(ArgumentError) { NumRb.array_multiply(arr1, arr2) }
  end

  # 大きな配列のテスト
  def test_large_array
    arr1 = Array.new(1000) { |i| i.to_f }
    arr2 = Array.new(1000) { |i| (i * 2).to_f }
    result = NumRb.array_add(arr1, arr2)
    assert_equal(1000, result.length)
    assert_in_delta(0.0, result[0], 0.0001)
    assert_in_delta(2997.0, result[999], 0.0001)
  end
end
