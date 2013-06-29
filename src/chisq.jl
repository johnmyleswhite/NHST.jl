# NB: If expected_bins not given, assume uniform distribution over bins

# TODO: Add ci()
# TODO: Add one-sided hypothesis tests

immutable ChisqTest <: HypothesisTest
    test_name::ASCIIString
    # Chi-squared
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
                        T <: Real}(::Type{ChisqTest},
                                   bins::Vector{S},
                                   expected_bins::Vector{T})
    n = length(bins)
    chisq = 0.0
    for i in 1:n
        if expected_bins[i] < 0.0
            throw(ArgumentError("Negative expected values are not allowed"))
        end
        chisq += (bins[i] - expected_bins[i])^2 / expected_bins[i]
    end
    return chisq
end

function test_statistic{T <: Real}(::Type{ChisqTest},
                                   bins::Vector{T})
    n, s = length(bins), sum(bins)
    val = s / n
    chisq = 0.0
    for i in 1:n
        chisq += (bins[i] - val)^2 / val
    end
    return chisq
end

function p_value{S <: Real,
                 T <: Real}(::Type{ChisqTest},
                            bins::Vector{S},
                            expected_bins::Vector{T})
    chisq = test_statistic(ChisqTest, bins, expected_bins)
    df = length(bins) - 1
    return ccdf(Chisq(df), chisq)
end

function p_value{T <: Real}(::Type{ChisqTest},
                            bins::Vector{T})
    chisq = test_statistic(ChisqTest, bins)
    df = length(bins) - 1
    return ccdf(Chisq(df), chisq)
end

function Base.run{S <: Real,
                  T <: Real}(::Type{ChisqTest},
                             bins::Vector{S},
                             expected_bins::Vector{T})
    n = length(bins)
    df = n - 1.0
    chisq = test_statistic(ChisqTest, bins, expected_bins)
    return ChisqTest("Chi-squared Test",
                     chisq,
                     NaN,
                     ccdf(Chisq(df), chisq),
                     [NaN, NaN],
                     NaN,
                     NaN,
                     "Two-sided",
                     "Chi-squared",
                     df)
end

function Base.run{T <: Real}(::Type{ChisqTest},
                             bins::Vector{T})
    n = length(bins)
    df = n - 1.0
    chisq = test_statistic(ChisqTest, bins)
    return ChisqTest("Chi-squared Test",
                     chisq,
                     NaN,
                     ccdf(Chisq(df), chisq),
                     [NaN, NaN],
                     NaN,
                     NaN,
                     "Two-sided",
                     "Chi-squared",
                     df)
end
