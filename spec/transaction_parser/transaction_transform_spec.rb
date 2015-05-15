require "bigdecimal"
require "transaction/transform"

class Transaction::Parser::TransactionTransformSpec < MiniTest::Spec
  subject { Transaction::Transform.new }

  describe "amount" do
    it { subject.apply(dollars:     "1", cents: "99").must_equal(BigDecimal(   "1.99")) }
    it { subject.apply(dollars: "1 042", cents: "99").must_equal(BigDecimal("1042.99")) }
  end

  describe "posted_on" do
    it { subject.apply(day: "15", year: "2015", month: "MAR").must_equal(Date.new(2015, 3, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "mar").must_equal(Date.new(2015, 3, 15)) }

    it { subject.apply(day: "15", year: "2015", month: "jan").must_equal(Date.new(2015,  1, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "feb").must_equal(Date.new(2015,  2, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "mar").must_equal(Date.new(2015,  3, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "apr").must_equal(Date.new(2015,  4, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "may").must_equal(Date.new(2015,  5, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "jun").must_equal(Date.new(2015,  6, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "jul").must_equal(Date.new(2015,  7, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "aug").must_equal(Date.new(2015,  8, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "sep").must_equal(Date.new(2015,  9, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "oct").must_equal(Date.new(2015, 10, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "nov").must_equal(Date.new(2015, 11, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "dec").must_equal(Date.new(2015, 12, 15)) }

    it { subject.apply(day: "15", year: "2015", month: "JAN").must_equal(Date.new(2015,  1, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "FEB").must_equal(Date.new(2015,  2, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "MAR").must_equal(Date.new(2015,  3, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "APR").must_equal(Date.new(2015,  4, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "MAY").must_equal(Date.new(2015,  5, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "JUN").must_equal(Date.new(2015,  6, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "JUL").must_equal(Date.new(2015,  7, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "AUG").must_equal(Date.new(2015,  8, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "SEP").must_equal(Date.new(2015,  9, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "OCT").must_equal(Date.new(2015, 10, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "NOV").must_equal(Date.new(2015, 11, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "DEC").must_equal(Date.new(2015, 12, 15)) }

    it { subject.apply(day: "15", year: "2015", month: "JAN").must_equal(Date.new(2015,  1, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "FÉV").must_equal(Date.new(2015,  2, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "FÉV").must_equal(Date.new(2015,  2, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "MAR").must_equal(Date.new(2015,  3, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "AVR").must_equal(Date.new(2015,  4, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "MAI").must_equal(Date.new(2015,  5, 15)) }
    # it { subject.apply(day: "15", year: "2015", month: "JUI").must_equal(Date.new(2015,  6, 15)) }
    # it { subject.apply(day: "15", year: "2015", month: "JUI").must_equal(Date.new(2015,  7, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "AOU").must_equal(Date.new(2015,  8, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "AOÛ").must_equal(Date.new(2015,  8, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "SEP").must_equal(Date.new(2015,  9, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "OCT").must_equal(Date.new(2015, 10, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "NOV").must_equal(Date.new(2015, 11, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "DEC").must_equal(Date.new(2015, 12, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "DÉC").must_equal(Date.new(2015, 12, 15)) }

    it { subject.apply(day: "15", year: "2015", month: "jan").must_equal(Date.new(2015,  1, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "fév").must_equal(Date.new(2015,  2, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "fév").must_equal(Date.new(2015,  2, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "mar").must_equal(Date.new(2015,  3, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "avr").must_equal(Date.new(2015,  4, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "mai").must_equal(Date.new(2015,  5, 15)) }
    # it { subject.apply(day: "15", year: "2015", month: "jui").must_equal(Date.new(2015,  6, 15)) }
    # it { subject.apply(day: "15", year: "2015", month: "jui").must_equal(Date.new(2015,  7, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "aou").must_equal(Date.new(2015,  8, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "aoû").must_equal(Date.new(2015,  8, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "sep").must_equal(Date.new(2015,  9, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "oct").must_equal(Date.new(2015, 10, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "nov").must_equal(Date.new(2015, 11, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "dec").must_equal(Date.new(2015, 12, 15)) }
    it { subject.apply(day: "15", year: "2015", month: "déc").must_equal(Date.new(2015, 12, 15)) }
  end
end
