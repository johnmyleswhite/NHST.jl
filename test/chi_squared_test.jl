load("NHST")
using NHST

bins = [3, 4, 8]
expected_bins = [8, 4, 3]
p = [8 / 15, 4 / 15, 3 / 15]

@assert abs(chi_squared_test(bins).p_value - 0.246597) < 10e-4
@assert abs(chi_squared_test(bins).statistic - 2.8) < 10e-4

@assert abs(chi_squared_test(bins, expected_bins).p_value - 0.003249784) < 10e-4
@assert abs(chi_squared_test(bins, expected_bins).statistic - 11.45833) < 10e-4
