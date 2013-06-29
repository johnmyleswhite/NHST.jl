# Use Welch's t-test to cope with unequal sample sizes and unequal variance.
# Could (should?) use other methods in other cases.

immutable TTest <: HypothesisTest
    test_name::ASCIIString
    # t statistic
    statistic::Float64
    parameter::Float64
    p_value::Float64
    confidence_interval::Vector{Float64}
    estimate::Float64
    null_value::Float64
    alternative_hypothesis::ASCIIString
    method::ASCIIString
    degrees_of_freedom::Float64
end

function test_statistic{S <: Real,
                        T <: Real}(::Type{TTest},
                                   x::Vector{S},
                                   y::Vector{T})
    n_x, n_y = length(x), length(y)
    x_bar, y_bar = mean(x), mean(y)
    s_x, s_y = var(x), var(y)
    s_welch = s_x / n_x + s_y / n_y
    return (x_bar - y_bar) / sqrt(s_welch)
end

test_statistic(t::TTest) = t.statistic

function ci{S <: Real,
            T <: Real}(::Type{TTest},
                       x::Vector{S},
                       y::Vector{T})
    n_x, n_y = length(x), length(y)
    x_bar, y_bar = mean(x), mean(y)
    s_x, s_y = var(x), var(y)
    s_welch = s_x / n_x + s_y / n_y
    t = (x_bar - y_bar) / sqrt(s_welch)
    df_num = (s_x / n_x + s_y / n_y)^2
    df_denom = ((s_x / n_x)^2) / (n_x - 1) + ((s_y / n_y)^2) / (n_y - 1)
    df = df_num / df_denom
    tau = abs(quantile(TDist(df), 0.05 / 2))
    return [(x_bar - y_bar) - tau * sqrt(s_welch), (x_bar - y_bar) + tau * sqrt(s_welch)]
end

ci(t::TTest) = t.confidence_interval

function p_value{S <: Real,
                 T <: Real}(::Type{TTest},
                            x::Vector{S},
                            y::Vector{T})
    n_x, n_y = length(x), length(y)
    x_bar, y_bar = mean(x), mean(y)
    s_x, s_y = var(x), var(y)
    s_welch = s_x / n_x + s_y / n_y
    t = (x_bar - y_bar) / sqrt(s_welch)
    df_num = (s_x / n_x + s_y / n_y)^2
    df_denom = ((s_x / n_x)^2) / (n_x - 1) + ((s_y / n_y)^2) / (n_y - 1)
    df = df_num / df_denom
    return 2.0 * (1.0 - cdf(TDist(df), abs(t)))
end

p_value(t::TTest) = t.p_value

function Base.run{S <: Real,
                  T <: Real}(::Type{TTest},
                             x::Vector{S},
                             y::Vector{T})
    n_x, n_y = length(x), length(y)
    x_bar, y_bar = mean(x), mean(y)
    s_x, s_y = var(x), var(y)
    s_welch = s_x / n_x + s_y / n_y
    t = (x_bar - y_bar) / sqrt(s_welch)
    df_num = (s_x / n_x + s_y / n_y)^2
    df_denom = ((s_x / n_x)^2) / (n_x - 1) + ((s_y / n_y)^2) / (n_y - 1)
    df = df_num / df_denom
    tau = abs(quantile(TDist(df), 0.05 / 2))
    ci = [(x_bar - y_bar) - tau * sqrt(s_welch), (x_bar - y_bar) + tau * sqrt(s_welch)]
    p = 2.0 * (1.0 - cdf(TDist(df), abs(t)))
    return TTest("t-Test",
                 t,
                 x_bar - y_bar,
                 p,
                 ci,
                 x_bar - y_bar,
                 0.0,
                 "Two-sided",
                 "Welch Two Sample t-test",
                 df)
end
