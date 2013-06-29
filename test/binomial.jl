using NHST

@assert isapprox(p_value(BinomialTest, 0, 10, 0.5), 0.001953125)
@assert isapprox(p_value(BinomialTest, 5, 10, 0.5), 1.0)
@assert isapprox(p_value(BinomialTest, 10, 10, 0.5), 0.001953125)
@assert isapprox(p_value(BinomialTest, 4, 10, 0.2), 0.1208739)
@assert isapprox(p_value(BinomialTest, 2, 10, 0.8), 7.79264e-05)
@assert isapprox(p_value(BinomialTest, 3, 100, 0.5), 2.630867e-25)
@assert isapprox(p_value(BinomialTest, 97, 100, 0.5), 2.630867e-25)
@assert isapprox(p_value(BinomialTest, 3, 10, 0.79), 0.001178273)
@assert isapprox(p_value(BinomialTest, 9, 10, 0.79), 0.6989298)

p_value(BinomialTest, 0, 10, 0.5)
p_value(BinomialTest, 0.0, 10, 0.5)
p_value(BinomialTest, 0, 10.0, 0.5)
p_value(BinomialTest, 0.0, 10.0, 0.5)
p_value(BinomialTest, zeros(10), 0.5)

run(BinomialTest, 0, 10, p = 0.5)
run(BinomialTest, 0.0, 10, p = 0.5)
run(BinomialTest, 0, 10.0, p = 0.5)
run(BinomialTest, 0.0, 10.0, p = 0.5)
run(BinomialTest, zeros(10), p = 0.5)

@assert isapprox(p_value(run(BinomialTest, 0, 10, p = 0.5)), 0.001953125)
@assert isapprox(p_value(run(BinomialTest, 5, 10, p = 0.5)), 1.0)
@assert isapprox(p_value(run(BinomialTest, 10, 10, p = 0.5)), 0.001953125)
@assert isapprox(p_value(run(BinomialTest, 4, 10, p = 0.2)), 0.1208739)
@assert isapprox(p_value(run(BinomialTest, 2, 10, p = 0.8)), 7.79264e-05)
