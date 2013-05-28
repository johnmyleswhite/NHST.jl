# Null Hypothesis Significance Tests for Julia

* t-tests via Welch's two sample method
* The exact binomial test
* The chi-squared test

# Installation

    Pkg.add("NHST")

# Usage Examples

## t-Test

    using NHST

    srand(1)

    x = randn(10)
    y = x + 1

    t_test(x, y)

## Binomial Test

    using NHST

    binom_test(40, 100, 0.5)

## Chi-Squared Test

	using NHST

	chi_squared_test([3, 4, 8])

	chi_squared_test([3, 4, 8], [8, 4, 3])

# Coming Soon

* Permutation tests
* The K/S test
