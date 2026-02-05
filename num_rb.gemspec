Gem::Specification.new do |spec|
  spec.name          = "num_rb"
  spec.version       = "0.1.0"
  spec.authors       = ["Yuina Watanabe"]
  spec.email         = ["y.azarea.w@yahoo.ne.jp"]

  spec.summary       = "High-performance numerical computing library for Ruby"
  spec.description   = "NumRb is a numerical computing library powered by Zig for high-performance array operations"
  spec.homepage      = "https://github.com/yuina368/num_rb"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.files         = Dir["{lib,ext}/**/*", "LICENSE", "README.md"]
  spec.require_paths = ["lib"]
  spec.extensions    = ["ext/num_rb/extconf.rb"]

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/your-username/num_rb"
end
