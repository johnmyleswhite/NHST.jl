function binom_p_value(x::Real, n::Real, p::Real)
  x = int(x)
  n = int(n)

  d = Binomial(n, p)

  expectation = p * n

  if x == expectation
    return 1.0
  end

  if x != 0.0 && p == 0.0
    return 0.0
  end

  if x != 1.0 && p == 1.0
    return 0.0
  end

  if x < expectation
    # Try to do less work than searching up from ceil(expectation).
    if pmf(d, floor(2 * expectation - x - 1)) > pmf(d, x)
      b = min(filter(i -> pmf(d, i) <= pmf(d, x),
                     [floor(2 * expectation - x - 1):n]))
    else
      b = min(filter(i -> pmf(d, i) <= pmf(d, x),
                     [ceil(expectation):n]))
    end
    return cdf(d, x) + ccdf(d, b - 1)
  else
    # Try to do less work than searching up to floor(expectation).
    if pmf(d, ceil(2 * expectation - x + 1)) > pmf(d, x)
      a = max(filter(i -> pmf(d, i) <= pmf(d, x),
                     [0.0:ceil(2 * expectation - x + 1)]))
    else
      a = max(filter(i -> pmf(d, i) <= pmf(d, x),
                     [0.0:floor(expectation)]))
    end
    return cdf(d, a) + ccdf(d, x - 1)
  end
end

function binom_test(x::Real, n::Real, p::Real)
  results = HypothesisTest()

  results.test_name = "Binomial Test"
  results.statistic = x
  results.parameter = p
  results.p_value = binom_p_value(x, n, p)
  results.confidence_interval = [x / n, x / n]
  results.estimate = x / n
  results.null_value = p
  results.alternative_hypothesis = "two-sided"
  results.method = "Exact binomial test"
  results.data_name = ["x", "n"]

  results
end
