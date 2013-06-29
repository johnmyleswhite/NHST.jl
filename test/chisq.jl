using NHST

bins = [3, 4, 8]
expected_bins = [8, 4, 3]

@assert isapprox(p_value(run(ChisqTest, bins)), 0.246597)
@assert isapprox(test_statistic(run(ChisqTest, bins)), 2.8)

@assert isapprox(p_value(ChisqTest, bins), 0.246597)
@assert isapprox(test_statistic(ChisqTest, bins), 2.8)

@assert isapprox(p_value(run(ChisqTest, bins, expected_bins)), 0.003249784)
@assert isapprox(test_statistic(run(ChisqTest, bins, expected_bins)), 11.45833)

@assert isapprox(p_value(ChisqTest, bins, expected_bins), 0.003249784)
@assert isapprox(test_statistic(ChisqTest, bins, expected_bins), 11.45833)
