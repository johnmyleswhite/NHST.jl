# Null Hypothesis Significance Tests for Julia

* t-tests via Welch's two sample method
* The exact binomial test
* The chi-squared test
* The permutation test

# Installation

    require("pkg")
    Pkg.add("NHST")

# Usage Examples

## t-Test

    load("NHST")
    
    srand(1)
    
    x = randn(10)
    y = x + 1
    
    t_test(x, y)

## Binomial Test

    load("NHST")
    
    binom_test(40, 100, 0.5)

## Chi-Squared Test

    load("NHST")
	
	chi_squared_test([3, 4, 8])

	chi_squared_test([3, 4, 8], [8, 4, 3])

## Permutation Test

    load("NHST")
	
	srand(1)
	
	x = randn(10)
	y = randn(5) + 10
	
	test_statistic = function(x, y)
		abs(mean(x) - mean(y))
	end
	
	permutation_test(x, y, test_statistic, 1000)

# Coming Soon

* The K/S test
