require "parslet"
require "transaction"
require "transaction/transform"

class Transaction
  def self.parse(str)
    return [] if str.to_s.strip.empty?

    parser = Parser.new
    parser.parse(str.downcase)
  rescue Parslet::ParseFailed => failure
    STDERR.puts failure.cause.ascii_tree
    raise
  end

  class Parser < Parslet::Parser
    rule(:space)     { match('\s').repeat(1) }
    rule(:space?)    { space.maybe }
    rule(:fullstop)  { str(".") }
    rule(:fullstop?) { fullstop.maybe }

    rule(:day)       { match('[0-9]').repeat(1).as(:day) >> space? }
    rule(:month)     {
      Transaction::Transform::NAME_TO_MONTH.keys.map(&method(:str)).reduce{|a, b| a | b}.as(:month) >> fullstop? >> space?
    }
    rule(:year)      { (str("2") >> match["0-9"].repeat(3)).as(:year) >> space? }
    rule(:posted_on) { day >> month >> year }

    rule(:dollars)   {
      # NOTE: order dependent; we must attempt the longest matches first, in case they fail
      # TODO: Generalize in order to parse arbitrarily large numbers: we're limited to 999 million dollars
      match['1-9'] >> (
        match['0-9'].repeat(1, 2) >> space >> match['0-9'] >> match['0-9'] >> match['0-9'] >> space >> match['0-9'].repeat(3) |
        space >> match['0-9'].repeat(1,2) >> match['0-9'] >> space >> match['0-9'].repeat(3) |
        match['0-9'].repeat(1, 2) >> space >> match['0-9'].repeat(3) |
        space >> match['0-9'].repeat(3)
      ) |
      ( match['1-9'] >> match['0-9'].repeat ) |
      ( str('0') )
    }
    rule(:cents)     { match['0-9'].repeat(2) }
    rule(:amount)    { dollars.as(:dollars) >> ( str(".") | str(",") ) >> cents.as(:cents) }

    root :posted_on
  end
end
