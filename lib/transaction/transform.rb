require "parslet"
require "transaction"

class Transaction::Transform < Parslet::Transform 
  rule(dollars: simple(:dollars), cents: simple(:cents)) { BigDecimal("#{dollars.gsub(/\s*/, "")}.#{cents}") }
end
