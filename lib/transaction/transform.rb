require "date"
require "parslet"
require "transaction"

class Transaction::Transform < Parslet::Transform 
  rule(dollars: simple(:dollars), cents: simple(:cents)) { BigDecimal("#{dollars.gsub(/\s*/, "")}.#{cents}") }
  rule(day: simple(:day), month: simple(:month), year: simple(:year)) do
    monthn = NAME_TO_MONTH.fetch(month)
    Date.new(Integer(year), monthn, Integer(day))
  end

  # All the months that the parser recognizes
  NAME_TO_MONTH = {
    "JAN" =>  1,
    "FEB" =>  2,
    "MAR" =>  3,
    "APR" =>  4,
    "MAY" =>  5,
    "JUN" =>  6,
    "JUL" =>  7,
    "AUG" =>  8,
    "SEP" =>  9,
    "OCT" => 10,
    "NOV" => 11,
    "DEC" => 12,

    # Again, lowercased
    "jan" =>  1,
    "feb" =>  2,
    "mar" =>  3,
    "apr" =>  4,
    "may" =>  5,
    "jun" =>  6,
    "jul" =>  7,
    "aug" =>  8,
    "sep" =>  9,
    "oct" => 10,
    "nov" => 11,
    "dec" => 12,

    # Add French month names, where they differ
    "FEV" =>  2,
    "FÉV" =>  2,
    "AVR" =>  4,
    "MAI" =>  5,
    "AOU" =>  8,
    "AOÛ" =>  8,
    "DÉC" => 12,

    # Again, lowercased
    "fev" =>  2,
    "fév" =>  2,
    "avr" =>  4,
    "mai" =>  5,
    "aou" =>  8,
    "aoû" =>  8,
    "déc" => 12,

    # Notice we skipped juin and juillet: both have the same prefix and introduce
    # confusion in the grammar. Wait for more data before going further down this
    # path.
  }.freeze
end
