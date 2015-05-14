require "bigdecimal"
require "transaction/transform"

class Transaction::Parser::AmountTransformSpec < MiniTest::Spec
  subject { Transaction::Transform.new }

  it { subject.apply(dollars:     "1", cents: "99").must_equal(BigDecimal(   "1.99")) }
  it { subject.apply(dollars: "1 042", cents: "99").must_equal(BigDecimal("1042.99")) }
end
