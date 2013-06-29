using Distributions
using NHST

srand(1)

x = randn(20)
y = 1.0 + randn(20)

@assert isapprox(test_statistic(TTest, x, y), -2.8204)
@assert isapprox(p_value(TTest, x, y), 0.00758227)
@assert isapprox(ci(TTest, x, y)[1], -1.5176904)
@assert isapprox(ci(TTest, x, y)[2], -0.2493534)

@assert isapprox(test_statistic(run(TTest, x, y)), -2.8204)
@assert isapprox(p_value(run(TTest, x, y)), 0.00758227)
@assert isapprox(ci(run(TTest, x, y))[1], -1.5176904)
@assert isapprox(ci(run(TTest, x, y))[2], -0.2493534)

run(TTest, x, y)
