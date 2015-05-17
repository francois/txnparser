require "minitest/spec"
require "parsing"
require "transaction/parser"

class Transaction::Parser::TransactionParserSpec < MiniTest::Spec
  include Parsing

  subject { Transaction::Parser.new.transaction }

  # TODO: consume and ignore space in the parser after the description
  it { parsing("05 MAI 2015   KOODO MOBILE PAC EDMONTON AB  23,45").must_equal(posted_on: {day: "05", month: "MAI", year: "2015"}, desc1: "KOODO MOBILE PAC EDMONTON AB  ", amount: {dollars: "23", cents: "45"}) }
  it { parsing("04 mai 2015   VIR INTERAC - 9994  900.00    ").must_equal(posted_on: {day: "04", month: "mai", year: "2015"}, desc1: "VIR INTERAC - 9994  ", amount: {dollars: "900", cents: "00"}) }
end
