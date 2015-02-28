require "spec_helper"

describe PolishCalculator do
  it "builds simple trees" do
    calculator = PolishCalculator.new(%w[1 2 +])

    expect(calculator.nodes.root).to       eq "+"
    expect(calculator.nodes.left.root).to  eq 2
    expect(calculator.nodes.right.root).to eq 1
  end

  it "builds recursive trees" do
    calculator = PolishCalculator.new(%w[5 1 3 + 4 * + 6 *])

    expect(calculator.nodes.root).to                        eq "*"
    expect(calculator.nodes.left.root).to                   eq 6
    expect(calculator.nodes.right.root).to                  eq "+"
    expect(calculator.nodes.right.left.root).to             eq "*"
    expect(calculator.nodes.right.left.left.root).to        eq 4
    expect(calculator.nodes.right.left.right.root).to       eq "+"
    expect(calculator.nodes.right.left.right.left.root).to  eq 3
    expect(calculator.nodes.right.left.right.right.root).to eq 1
    expect(calculator.nodes.right.right.root).to            eq 5
  end

  it "describes whether a node is reducible" do
    calculator = PolishCalculator.new(%w[5 1 3 + 4 * + 6 *])

    expect(calculator.nodes.left.reducible?).to  be false
    expect(calculator.nodes.right.reducible?).to be true
  end

  it "reduces values" do
    calculator = PolishCalculator.new(%w[5 1 *])

    expect(calculator.calculate).to eq 5
  end

  it "reduces (1 (3 4 *) +) to 13" do
    calculator = PolishCalculator.new(%w(1 3 4 * +))

    expect(calculator.calculate).to eq 13
  end

  it "reduces ((1 3 *) 4 +) to 7" do
    calculator = PolishCalculator.new(%w(1 3 * 4 +))

    expect(calculator.calculate).to eq 7
  end

  it "reduces ((5 ((1 3 +) 4 *) +) 6 *) to 126" do
    calculator = PolishCalculator.new(%w[5 1 3 + 4 * + 6 *])

    expect(calculator.calculate).to eq 126
  end
end
