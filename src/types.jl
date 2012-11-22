type HypothesisTest
  test_name
  statistic
  parameter
  p_value::Number
  confidence_interval
  estimate
  null_value
  alternative_hypothesis::String
  method::String
  data_name
  degrees_of_freedom
end

HypothesisTest() = HypothesisTest("Unspecified Test",
                                  0,
                                  0,
                                  0.0,
                                  [0, 0],
                                  0,
                                  0,
                                  "No Alternative Specified",
                                  "No Method Specified",
                                  0,
                                  0)

function print(ht::HypothesisTest)
  print(summary(ht))
end

function show(ht::HypothesisTest)
  print(summary(ht))
end

function summary(ht::HypothesisTest)
  output = ""
  output = strcat(output, "Results of Hypothesis Test\n")
  output = strcat(output, "Parameter: ", ht.parameter, "\n")
  if ht.p_value < 10e-16
    output = strcat(output, "p < 10e-16\n")
  else
    output = strcat(output, "p < ", ht.p_value, "\n")
  end
  output = strcat(output, "Confidence Interval: ", ht.confidence_interval, "\n")
  output = strcat(output, "Estimate: ", ht.estimate, "\n")
  output = strcat(output, "Null Value: ", ht.null_value, "\n")
  output = strcat(output, "Alternative Hypothesis: ", ht.alternative_hypothesis, "\n")
  output = strcat(output, "Method: ", ht.method, "\n")
  output = strcat(output, "Data Name: ", ht.data_name, "\n")
  output = strcat(output, "Degrees of Freedom: ", ht.degrees_of_freedom, "\n")
  
  output
end
