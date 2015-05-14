require "minitest/spec"
require "parsing"
require "transaction/parser"

class Transaction::Parser::PostedOnParserSpec < MiniTest::Spec
  include Parsing

  subject { Transaction::Parser.new.posted_on }

  it { parsing("15 avr 2015").must_equal(day: "15", month: "avr", year: "2015") }
  it { parsing("04 avr. 2015").must_equal(day: "04", month: "avr", year: "2015") }
  it { parsing("15 AVR 2015").must_equal(day: "15", month: "AVR", year: "2015") }

  it "fails the empty string" do
    proc { subject.parse("") }.must_raise Parslet::ParseFailed
  end
end
