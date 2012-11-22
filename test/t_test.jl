load("Distributions")
using Distributions

load("NHST")
using NHST

srand(1)

x = randn(20)
y = 1 + randn(20)

results = t_test(x, y)

@assert results.null_value == 0.0
@assert results.p_value == 2.0 * (1.0 - cdf(TDist(results.parameter["df"]), abs(results.statistic["t"])))
@assert mean(results.confidence_interval) == results.estimate["mean of x"] - results.estimate["mean of y"]
@assert results.method == "Welch Two Sample t-test"
@assert results.alternative_hypothesis == "two-sided"
