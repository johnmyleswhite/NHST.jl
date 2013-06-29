# TODO: Add ci()
# TODO: Add one-sided hypothesis tests

immutable BinomialTest <: HypothesisTest
    test_name::ASCIIString
    # Number of Successes
    statistic::Int
    # Test parameter: p
    parameter::Float64
    p_value::Float64
    confidence_interval::Vector{Float64}
    estimate::Float64
    null_value::Float64
    alternative_hypothesis::ASCIIString
    method::ASCIIString
end

function p_value(::Type{BinomialTest},
                 x::Integer,
                 n::Integer,
                 p::Real)
    d = Binomial(n, p)
    expectation = mean(d)

    if x == expectation
        return 1.0
    end

    if (x != 0 && p == 0.0) || (x != n && p == 1.0)
        return 0.0
    end

    mirror = expectation + (expectation - x) - 1.0

    pv = pmf(d, x)

    if x < expectation
        # TODO: Perform a binary search here
        if pmf(d, ifloor(mirror)) > pv
            lower_bound = ifloor(mirror)
        else
            lower_bound = iceil(expectation)
        end
        for i in lower_bound:n
            if pmf(d, i) <= pv
                return cdf(d, x) + ccdf(d, i - 1)
            end
        end
        return cdf(d, x)
    else
        # TODO: Perform a binary search here
        if pmf(d, iceil(mirror)) > pv
            upper_bound = iceil(mirror)
        else
            upper_bound = ifloor(expectation)
        end
        for i in upper_bound:-1:0
            if pmf(d, i) <= pv
                return cdf(d, i) + ccdf(d, x - 1)
            end
        end
        return ccdf(d, x - 1)
    end
end

function p_value(::Type{BinomialTest},
                 s::Real,
                 n::Real,
                 p::Real)
    p_value(BinomialTest, int(s), int(n), p)
end

function p_value{T <: Real}(::Type{BinomialTest},
                            x::Vector{T},
                            p::Real)
    p_value(BinomialTest, int(sum(x)), length(x), p)
end

function Base.run(::Type{BinomialTest},
                  s::Int,
                  n::Int;
                  p::Float64 = 0.5)
    return BinomialTest("Binomial Test",
                        s,
                        p,
                        p_value(BinomialTest, s, n, p),
                        [NaN, NaN],
                        s / n,
                        p,
                        "Two-sided",
                        "Exact binomial test")
end

function Base.run(::Type{BinomialTest},
                  s::Real,
                  n::Real;
                  p::Real = 0.5)
    Base.run(BinomialTest, int(s), int(n), p = float64(p))
end

function Base.run{T <: Real}(::Type{BinomialTest},
                             x::Vector{T};
                             p::Real = 0.5)
    Base.run(BinomialTest, int(sum(x)), length(x), p = float64(p))
end
