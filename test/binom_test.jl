load("NHST")
using NHST

# binom_p_value

@assert abs(binom_p_value(0, 10, 0.5) - 0.001953125) < 10e-8

@assert abs(binom_p_value(5, 10, 0.5) - 1.0) < 10e-8

@assert abs(binom_p_value(10, 10, 0.5) - 0.001953125) < 10e-8

@assert abs(binom_p_value(4, 10, 0.2) - 0.1208739) < 10e-8

@assert abs(binom_p_value(2, 10, 0.8) - 7.79264e-05) < 10e-8

@assert abs(binom_p_value(3, 100, 0.5) - 2.630867e-25) < 10e-8

@assert abs(binom_p_value(97, 100, 0.5) - 2.630867e-25) < 10e-8

@assert abs(binom_p_value(3, 10, 0.79) - 0.001178273) < 10e-8

@assert abs(binom_p_value(9, 10, 0.79) - 0.6989298) < 10e-8

# binom_test

@assert abs(binom_test(0, 10, 0.5).p_value - 0.001953125) < 10e-8

@assert abs(binom_test(5, 10, 0.5).p_value - 1.0) < 10e-8

@assert abs(binom_test(10, 10, 0.5).p_value - 0.001953125) < 10e-8

@assert abs(binom_test(4, 10, 0.2).p_value - 0.1208739) < 10e-8

@assert abs(binom_test(2, 10, 0.8).p_value - 7.79264e-05) < 10e-8
