require "minitest/spec"
require "parsing"
require "transaction/parser"

class Transaction::Parser::AmountParserSpec < MiniTest::Spec
  include Parsing

  subject { Transaction::Parser.new.amount }

  it { parsing("0.00").must_equal(dollars: "0", cents: "00") }
  it { parsing("0,09").must_equal(dollars: "0", cents: "09") }
  it { parsing("0.99").must_equal(dollars: "0", cents: "99") }
  it { parsing("1.23").must_equal(dollars: "1", cents: "23") }
  it { parsing("1,23").must_equal(dollars: "1", cents: "23") }

  it { parsing(   "22,13").must_equal(dollars:    "22", cents: "13") }
  it { parsing(  "422,13").must_equal(dollars:   "422", cents: "13") }
  it { parsing( "1422.13").must_equal(dollars:  "1422", cents: "13") }
  it { parsing("10422,13").must_equal(dollars: "10422", cents: "13") }

  it { parsing(      "1 422,13").must_equal(dollars:       "1 422", cents: "13") }
  it { parsing(     "10 422,13").must_equal(dollars:      "10 422", cents: "13") }
  it { parsing(    "100 422,13").must_equal(dollars:     "100 422", cents: "13") }
  it { parsing(  "1 000 422,13").must_equal(dollars:   "1 000 422", cents: "13") }
  it { parsing( "90 000 422,13").must_equal(dollars:  "90 000 422", cents: "13") }
  it { parsing("999 999 999.99").must_equal(dollars: "999 999 999", cents: "99") }

  it { proc { subject.parse("01.23") }.must_raise Parslet::ParseFailed }
  it { proc { subject.parse("01.23") }.must_raise Parslet::ParseFailed }
  it { proc { subject.parse("00,23") }.must_raise Parslet::ParseFailed }
  it { proc { subject.parse("") }.must_raise      Parslet::ParseFailed }
  it { proc { subject.parse("1 999 999 999.99") }.must_raise Parslet::ParseFailed }
end
