#include <ruby.h>
#include <stdlib.h>

// Zigで実装された関数のプロトタイプ宣言
extern double zig_add(double a, double b);
extern double zig_subtract(double a, double b);
extern double zig_multiply(double a, double b);
extern double zig_divide(double a, double b);
extern double* zig_array_add(double* arr1, double* arr2, size_t len);
extern double* zig_array_multiply(double* arr1, double* arr2, size_t len);
extern double zig_array_sum(double* arr, size_t len);
extern double zig_array_mean(double* arr, size_t len);

VALUE rb_mNumRb;

// Ruby <-> C の変換関数
static VALUE rb_add(VALUE self, VALUE a, VALUE b) {
    double result = zig_add(NUM2DBL(a), NUM2DBL(b));
    return DBL2NUM(result);
}

static VALUE rb_subtract(VALUE self, VALUE a, VALUE b) {
    double result = zig_subtract(NUM2DBL(a), NUM2DBL(b));
    return DBL2NUM(result);
}

static VALUE rb_multiply(VALUE self, VALUE a, VALUE b) {
    double result = zig_multiply(NUM2DBL(a), NUM2DBL(b));
    return DBL2NUM(result);
}

static VALUE rb_divide(VALUE self, VALUE a, VALUE b) {
    double result = zig_divide(NUM2DBL(a), NUM2DBL(b));
    return DBL2NUM(result);
}

static VALUE rb_array_add(VALUE self, VALUE arr1, VALUE arr2) {
    Check_Type(arr1, T_ARRAY);
    Check_Type(arr2, T_ARRAY);
    
    long len = RARRAY_LEN(arr1);
    if (len != RARRAY_LEN(arr2)) {
        rb_raise(rb_eArgError, "Arrays must have the same length");
    }
    
    if (len == 0) {
        return rb_ary_new();
    }
    
    double* c_arr1 = malloc(sizeof(double) * len);
    double* c_arr2 = malloc(sizeof(double) * len);
    
    if (!c_arr1 || !c_arr2) {
        if (c_arr1) free(c_arr1);
        if (c_arr2) free(c_arr2);
        rb_raise(rb_eNoMemError, "Failed to allocate memory");
    }
    
    for (long i = 0; i < len; i++) {
        c_arr1[i] = NUM2DBL(rb_ary_entry(arr1, i));
        c_arr2[i] = NUM2DBL(rb_ary_entry(arr2, i));
    }
    
    double* result = zig_array_add(c_arr1, c_arr2, len);
    
    VALUE rb_result = rb_ary_new2(len);
    for (long i = 0; i < len; i++) {
        rb_ary_push(rb_result, DBL2NUM(result[i]));
    }
    
    // 修正: Zigのc_allocatorで確保したメモリもfreeで解放可能
    free(c_arr1);
    free(c_arr2);
    free(result);
    
    return rb_result;
}

static VALUE rb_array_multiply(VALUE self, VALUE arr1, VALUE arr2) {
    Check_Type(arr1, T_ARRAY);
    Check_Type(arr2, T_ARRAY);
    
    long len = RARRAY_LEN(arr1);
    if (len != RARRAY_LEN(arr2)) {
        rb_raise(rb_eArgError, "Arrays must have the same length");
    }
    
    if (len == 0) {
        return rb_ary_new();
    }
    
    double* c_arr1 = malloc(sizeof(double) * len);
    double* c_arr2 = malloc(sizeof(double) * len);
    
    if (!c_arr1 || !c_arr2) {
        if (c_arr1) free(c_arr1);
        if (c_arr2) free(c_arr2);
        rb_raise(rb_eNoMemError, "Failed to allocate memory");
    }
    
    for (long i = 0; i < len; i++) {
        c_arr1[i] = NUM2DBL(rb_ary_entry(arr1, i));
        c_arr2[i] = NUM2DBL(rb_ary_entry(arr2, i));
    }
    
    double* result = zig_array_multiply(c_arr1, c_arr2, len);
    
    VALUE rb_result = rb_ary_new2(len);
    for (long i = 0; i < len; i++) {
        rb_ary_push(rb_result, DBL2NUM(result[i]));
    }
    
    free(c_arr1);
    free(c_arr2);
    free(result);
    
    return rb_result;
}

static VALUE rb_array_sum(VALUE self, VALUE arr) {
    Check_Type(arr, T_ARRAY);
    
    long len = RARRAY_LEN(arr);
    
    if (len == 0) {
        return DBL2NUM(0.0);
    }
    
    double* c_arr = malloc(sizeof(double) * len);
    
    if (!c_arr) {
        rb_raise(rb_eNoMemError, "Failed to allocate memory");
    }
    
    for (long i = 0; i < len; i++) {
        c_arr[i] = NUM2DBL(rb_ary_entry(arr, i));
    }
    
    double result = zig_array_sum(c_arr, len);
    
    free(c_arr);
    
    return DBL2NUM(result);
}

static VALUE rb_array_mean(VALUE self, VALUE arr) {
    Check_Type(arr, T_ARRAY);
    
    long len = RARRAY_LEN(arr);
    
    if (len == 0) {
        return DBL2NUM(0.0);
    }
    
    double* c_arr = malloc(sizeof(double) * len);
    
    if (!c_arr) {
        rb_raise(rb_eNoMemError, "Failed to allocate memory");
    }
    
    for (long i = 0; i < len; i++) {
        c_arr[i] = NUM2DBL(rb_ary_entry(arr, i));
    }
    
    double result = zig_array_mean(c_arr, len);
    
    free(c_arr);
    
    return DBL2NUM(result);
}

void Init_num_rb(void) {
    rb_mNumRb = rb_define_module("NumRb");
    
    rb_define_singleton_method(rb_mNumRb, "add", rb_add, 2);
    rb_define_singleton_method(rb_mNumRb, "subtract", rb_subtract, 2);
    rb_define_singleton_method(rb_mNumRb, "multiply", rb_multiply, 2);
    rb_define_singleton_method(rb_mNumRb, "divide", rb_divide, 2);
    rb_define_singleton_method(rb_mNumRb, "array_add", rb_array_add, 2);
    rb_define_singleton_method(rb_mNumRb, "array_multiply", rb_array_multiply, 2);
    rb_define_singleton_method(rb_mNumRb, "array_sum", rb_array_sum, 1);
    rb_define_singleton_method(rb_mNumRb, "array_mean", rb_array_mean, 1);
}
