require 'benchmark'

# Using recursion
def factorial(num)
    if num <= 1
      1
    else
        num * factorial(num-1)
    end
end

# Using iteration

def iter_factorial(num)
  if num <= 1
    1
  else
    sum = 1
    num.times do |n|
      sum *= (n + 1)
    end
    sum
  end
end

Benchmark.bm do |x|
  x.report("recursion:")  { factorial(5000)}
  x.report("iteration:")  { iter_factorial(5000)}
end
