module NHST
  export binom_p_value, binom_test, chi_squared_test, t_test

  using Base

  load("Distributions")
  using Distributions

  load("NHST/src/types.jl")

  load("NHST/src/binom_test.jl")
  load("NHST/src/chi_squared_test.jl")
  load("NHST/src/t_test.jl")
end
