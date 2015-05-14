module Parsing
  def parsing(value)
    subject.parse(value)
  rescue Parslet::ParseFailed => e
    raise Minitest::Assertion, "While parsing: #{value.inspect}:\n#{e.cause.ascii_tree}"
  end
end
