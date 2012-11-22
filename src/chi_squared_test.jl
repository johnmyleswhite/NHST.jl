function chi_squared_test{S <: Real, T <: Real}(bins::Vector{S}, expected_bins::Vector{T})
  n = length(bins)

  if any(expected_bins .< 0.0)
    error("Negative expected values are not allowed")
  end

  chisq = sum(map(x -> x^2, bins .- expected_bins) ./ expected_bins)

  degrees_of_freedom = n - 1

  results = HypothesisTest()

  results.statistic = chisq
  results.p_value = ccdf(Chisq(degrees_of_freedom), chisq)
  results.degrees_of_freedom = degrees_of_freedom

  results
end

# If expected_bins not given, fill in uniform distribution over bins.
function chi_squared_test{T <: Real}(bins::Vector{T})
  n = length(bins)
  m = sum(bins)

  p = 1.0 / n * ones(n)

  expected_bins = p * m

  chi_squared_test(bins, expected_bins)
end
