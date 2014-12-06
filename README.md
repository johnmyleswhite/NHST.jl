NHST.jl
=======

# NOTICE

**This package is deprecated. Use HypothesisTests.jl instead.**

# Null Hypothesis Significance Tests for Julia

* t-tests via Welch's two sample method
* The exact binomial test
* The chi-squared test

# Usage Examples

    using NHST

    srand(1)

    x = randn(20)
    y = x + 1

    run(TTest, x, y)
    run(BinomialTest, 40, 100, p = 0.5)
	run(ChisqTest, [3, 4, 8])
	run(ChisqTest, [3, 4, 8], [8, 4, 3])

# Coming Soon

* Permutation tests
* The K/S test
