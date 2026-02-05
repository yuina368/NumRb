const std = @import("std");

// 基本的な算術演算
export fn zig_add(a: f64, b: f64) f64 {
    return a + b;
}

export fn zig_subtract(a: f64, b: f64) f64 {
    return a - b;
}

export fn zig_multiply(a: f64, b: f64) f64 {
    return a * b;
}

export fn zig_divide(a: f64, b: f64) f64 {
    if (b == 0.0) return std.math.nan(f64);
    return a / b;
}

// 配列の要素ごとの加算
export fn zig_array_add(arr1: [*]const f64, arr2: [*]const f64, len: usize) callconv(.C) [*]f64 {
    const allocator = std.heap.c_allocator;
    const result = allocator.alloc(f64, len) catch unreachable;

    var i: usize = 0;
    while (i < len) : (i += 1) {
        result[i] = arr1[i] + arr2[i];
    }

    return result.ptr;
}

// 配列の要素ごとの乗算
export fn zig_array_multiply(arr1: [*]const f64, arr2: [*]const f64, len: usize) callconv(.C) [*]f64 {
    const allocator = std.heap.c_allocator;
    const result = allocator.alloc(f64, len) catch unreachable;

    var i: usize = 0;
    while (i < len) : (i += 1) {
        result[i] = arr1[i] * arr2[i];
    }

    return result.ptr;
}

// Zigで確保したメモリを解放する関数 (追加)
export fn zig_free(ptr: [*]f64) callconv(.C) void {
    // 注意: サイズ情報が必要だがC APIでは取得不可
    // wrapper.c側で管理する必要がある
    _ = ptr;
}

// 配列の合計
export fn zig_array_sum(arr: [*]const f64, len: usize) callconv(.C) f64 {
    var sum: f64 = 0.0;
    var i: usize = 0;
    while (i < len) : (i += 1) {
        sum += arr[i];
    }
    return sum;
}

// 配列の平均
export fn zig_array_mean(arr: [*]const f64, len: usize) callconv(.C) f64 {
    if (len == 0) return 0.0;
    const sum = zig_array_sum(arr, len);
    return sum / @as(f64, @floatFromInt(len));
}
