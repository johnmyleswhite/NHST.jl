# immutable HypothesisTest
#     test_name::String
#     statistic::Any
#     parameter::Any
#     p_value::Real
#     confidence_interval::Array
#     estimate::Any
#     null_value::Any
#     alternative_hypothesis::String
#     method::String
#     degrees_of_freedom::Real
# end

abstract HypothesisTest

Base.show(io::IO, ht::HypothesisTest) = print(io, describe(ht))

function describe(ht::HypothesisTest)
    res = @sprintf "Results of Hypothesis Test\n"
    res *= @sprintf " * Test Statistic: %s\n" string(ht.statistic)
    res *= @sprintf " * Parameter: %s\n" string(ht.parameter)
    if ht.p_value < 1e-16
        res *= @sprintf " * p < 1e-16\n"
    else
        res *= @sprintf " * p < %f\n" ht.p_value
    end
    res *= @sprintf " * Confidence Interval: %s\n" string(ht.confidence_interval)
    res *= @sprintf " * Estimate: %s\n" string(ht.estimate)
    res *= @sprintf " * Null Value: %s\n" string(ht.null_value)
    res *= @sprintf " * Alternative Hypothesis: %s\n" string(ht.alternative_hypothesis)
    res *= @sprintf " * Method: %s\n" string(ht.method)
    if contains(typeof(ht).names, :degrees_of_freedom)
        res *= @sprintf " * Degrees of Freedom: %f" ht.degrees_of_freedom
    end
    return res
end

test_statistic(t::HypothesisTest) = t.statistic
p_value(t::HypothesisTest) = t.p_value
