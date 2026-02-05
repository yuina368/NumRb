# extディレクトリのパスを追加
$LOAD_PATH.unshift File.expand_path('../ext/num_rb', __dir__)
require 'num_rb'

module NumRb
  VERSION = "0.1.0"
  
  class Array
    def initialize(data)
      @data = data
    end
    
    def +(other)
      result = NumRb.array_add(@data, other.data)
      NumRb::Array.new(result)
    end
    
    def *(other)
      result = NumRb.array_multiply(@data, other.data)
      NumRb::Array.new(result)
    end
    
    def sum
      NumRb.array_sum(@data)
    end
    
    def mean
      NumRb.array_mean(@data)
    end
    
    def to_a
      @data
    end
    
    def inspect
      "NumRb::Array#{@data.inspect}"
    end
    
    protected
    
    attr_reader :data
  end
end
