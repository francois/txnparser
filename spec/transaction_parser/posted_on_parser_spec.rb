require "minitest/spec"
require "transaction/parser"

class Transaction::Parser::PostedOnParserSpec < MiniTest::Spec
  subject { Transaction::Parser.new.posted_on }

  it { subject.parse("15 avr 2015").must_equal(day: "15", month: "avr", year: "2015") }
  it { subject.parse("04 avr. 2015").must_equal(day: "04", month: "avr", year: "2015") }

  it "fails on uppercase month names" do
    proc { subject.parse("15 AVR 2015") }.must_raise Parslet::ParseFailed
  end

  it "fails the empty string" do
    proc { subject.parse("") }.must_raise Parslet::ParseFailed
  end
end
