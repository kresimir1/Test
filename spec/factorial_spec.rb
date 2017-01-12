require_relative '../lib/factorial'

describe "Factorial" do
  it "calculates the factorial of 1" do
    expect(factorial(1)).to eq 1
    expect(factorial(2)).to eq 2
    expect(factorial(3)).to eq 6
    expect(factorial(4)).to eq 24
    expect(factorial(5)).to eq 120
    expect(factorial(0)).to eq 1
  end
end
