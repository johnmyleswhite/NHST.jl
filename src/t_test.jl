# Use Welch's t-test to cope with unequal sample sizes and unequal variance.
# Could (should?) use other methods in other cases.

function t_test{S <: Real, T <: Real}(x::Vector{S}, y::Vector{T})
  x_bar = mean(x)
  y_bar = mean(y)

  s_x = var(x)
  s_y = var(y)

  n_x = length(x)
  n_y = length(y)

  s_hat = sqrt(s_x / n_x + s_y / n_y)

  t = (x_bar - y_bar) / s_hat

  df_num = (s_x / n_x + s_y / n_y)^2
  df_denom = ((s_x / n_x)^2) / (n_x - 1) + ((s_y / n_y)^2) / (n_y - 1)
  degrees_of_freedom = df_num / df_denom

  p_value = 2.0 * (1.0 - cdf(TDist(degrees_of_freedom), abs(t)))

  results = HypothesisTest()
  results.test_name = "t-Test"
  results.statistic = {"t" => t}
  results.parameter = {"df" => degrees_of_freedom}
  results.p_value = p_value
  results.confidence_interval = [(x_bar - y_bar) - 2 * s_hat, (x_bar - y_bar) + 2 * s_hat]
  results.estimate = {"mean of x" => x_bar, "mean of y" => y_bar}
  results.null_value = 0.0
  results.alternative_hypothesis = "two-sided"
  results.method = "Welch Two Sample t-test"
  results.data_name = "x and y"
  results.degrees_of_freedom = degrees_of_freedom

  results
end
