module NHST
    export t_test

    export test_statistic, p_value, ci
    export BinomialTest, ChisqTest, TTest

    using Distributions

	# :twosided, :greater, :less

    include("types.jl")
    include("binomial.jl")
    include("chisq.jl")
    include("ttest.jl")
end
