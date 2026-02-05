require 'mkmf'

# Zigコンパイラの存在確認
unless find_executable('zig')
  abort "Zig compiler not found. Please install Zig."
end

# Zigコンパイラでcore.zigを静的ライブラリとしてコンパイル
puts "Compiling Zig code..."
system("zig build-lib core.zig -static -O ReleaseFast -lc") or abort "Zig compilation failed"

# 静的ライブラリをリンク
$libs = append_library($libs, "core")
$LIBPATH.push(Dir.pwd)

# C拡張のMakefileを生成
create_makefile('num_rb/num_rb')
