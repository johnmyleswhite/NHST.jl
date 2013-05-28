module NHST
  export binom_p_value, binom_test, chi_squared_test, t_test

  using Base
  using Distributions

  include("types.jl")
  include("binom_test.jl")
  include("chi_squared_test.jl")
  include("t_test.jl")
end
