require "minitest/spec"
require "transaction/parser"

class Transaction::Parser::AmountParserSpec < MiniTest::Spec
  subject { Transaction::Parser.new.amount }

  it { parsing("1.23").must_equal(dollars: "1", cents: "23") }
  it { parsing("1,23").must_equal(dollars: "1", cents: "23") }
  it { parsing("22,13").must_equal(dollars: "22", cents: "13") }
  it { parsing("422,13").must_equal(dollars: "422", cents: "13") }
  it { parsing("1422,13").must_equal(dollars: "1422", cents: "13") }
  it { parsing("10422,13").must_equal(dollars: "10422", cents: "13") }

  # it { parsing("1 422,13").must_equal(dollars: "1 422", cents: "13") }
  # it { parsing("10 422,13").must_equal(dollars: "10 422", cents: "13") }

  it "fails the empty string" do
    proc { subject.parse("") }.must_raise Parslet::ParseFailed
  end

  def parsing(value)
    subject.parse(value)
  rescue Parslet::ParseFailed => e
    raise Minitest::Assertion, "While parsing: #{value.inspect}:\n#{e.cause.ascii_tree}"
  end
end
