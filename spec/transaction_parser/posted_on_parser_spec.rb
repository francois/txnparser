require "minitest/spec"
require "parsing"
require "transaction/parser"

class Transaction::Parser::PostedOnParserSpec < MiniTest::Spec
  include Parsing

  subject { Transaction::Parser.new.posted_on }

  it { parsing("04 jan. 2015").must_equal(day: "04", month: "jan", year: "2015") }
  it { parsing("04 jan 2015").must_equal(day: "04", month: "jan", year: "2015") }

  it { parsing("04 feb. 2015").must_equal(day: "04", month: "feb", year: "2015") }
  it { parsing("04 fev. 2015").must_equal(day: "04", month: "fev", year: "2015") }
  it { parsing("04 fév. 2015").must_equal(day: "04", month: "fév", year: "2015") }
  it { parsing("04 FEB. 2015").must_equal(day: "04", month: "FEB", year: "2015") }
  it { parsing("04 FEV. 2015").must_equal(day: "04", month: "FEV", year: "2015") }
  it { parsing("04 FÉV. 2015").must_equal(day: "04", month: "FÉV", year: "2015") }

  it { parsing("04 mar. 2015").must_equal(day: "04", month: "mar", year: "2015") }
  it { parsing("04 MAR. 2015").must_equal(day: "04", month: "MAR", year: "2015") }

  it { parsing("04 apr. 2015").must_equal(day: "04", month: "apr", year: "2015") }
  it { parsing("04 APR. 2015").must_equal(day: "04", month: "APR", year: "2015") }
  it { parsing("04 avr. 2015").must_equal(day: "04", month: "avr", year: "2015") }
  it { parsing("04 AVR. 2015").must_equal(day: "04", month: "AVR", year: "2015") }

  it { parsing("04 may 2015").must_equal(day: "04", month: "may", year: "2015") }
  it { parsing("04 MAY 2015").must_equal(day: "04", month: "MAY", year: "2015") }
  it { parsing("04 MAI 2015").must_equal(day: "04", month: "MAI", year: "2015") }
  it { parsing("04 mai 2015").must_equal(day: "04", month: "mai", year: "2015") }

  it { parsing("04 jun 2015").must_equal(day: "04", month: "jun", year: "2015") }
  it { parsing("04 JUN 2015").must_equal(day: "04", month: "JUN", year: "2015") }

  it { parsing("04 jul 2015").must_equal(day: "04", month: "jul", year: "2015") }
  it { parsing("04 JUL 2015").must_equal(day: "04", month: "JUL", year: "2015") }

  it { parsing("04 aug 2015").must_equal(day: "04", month: "aug", year: "2015") }
  it { parsing("04 AUG 2015").must_equal(day: "04", month: "AUG", year: "2015") }
  it { parsing("04 aou 2015").must_equal(day: "04", month: "aou", year: "2015") }
  it { parsing("04 aoû 2015").must_equal(day: "04", month: "aoû", year: "2015") }
  it { parsing("04 AOU 2015").must_equal(day: "04", month: "AOU", year: "2015") }
  it { parsing("04 AOÛ 2015").must_equal(day: "04", month: "AOÛ", year: "2015") }

  it { parsing("04 sep 2015").must_equal(day: "04", month: "sep", year: "2015") }
  it { parsing("04 SEP 2015").must_equal(day: "04", month: "SEP", year: "2015") }

  it { parsing("04 oct 2015").must_equal(day: "04", month: "oct", year: "2015") }
  it { parsing("04 OCT 2015").must_equal(day: "04", month: "OCT", year: "2015") }

  it { parsing("04 nov 2015").must_equal(day: "04", month: "nov", year: "2015") }
  it { parsing("04 NOV 2015").must_equal(day: "04", month: "NOV", year: "2015") }

  it { parsing("04 dec 2015").must_equal(day: "04", month: "dec", year: "2015") }
  it { parsing("04 déc 2015").must_equal(day: "04", month: "déc", year: "2015") }
  it { parsing("04 DEC 2015").must_equal(day: "04", month: "DEC", year: "2015") }
  it { parsing("04 DÉC 2015").must_equal(day: "04", month: "DÉC", year: "2015") }

  it "fails the empty string" do
    proc { subject.parse("") }.must_raise Parslet::ParseFailed
  end
end
