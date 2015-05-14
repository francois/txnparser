require "parslet"
require "transaction"

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
      (
        # Start with the 12 months in English
        str("jan") |
        str("feb") |
        str("mar") |
        str("apr") |
        str("jun") |
        str("jul") |
        str("aug") |
        str("sep") |
        str("oct") |
        str("nov") |
        str("dec") |

        # Add French month names, where they differ
        str("fév") |
        str("avr") |
        str("mai") |
        str("aou") |
        str("aoû") |
        str("déc")

        # Notice we skipped juin and juillet: both have the same prefix and introduce
        # confusion in the grammar. Wait for more data before going further down this
        # path.
      ).as(:month) >> fullstop? >> space?
    }
    rule(:year)      { (str("2") >> match["0-9"].repeat(3)).as(:year) >> space? }
    rule(:posted_on) { day >> month >> year }

    rule(:dollars)   { match['0-9'].repeat }
    rule(:cents)     { match['0-9'].repeat(2) }
    rule(:amount)    { dollars.as(:dollars) >> ( str(".") | str(",") ) >> cents.as(:cents) }

    root :posted_on
  end
end
