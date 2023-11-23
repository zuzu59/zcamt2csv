require './bank2csv.rb'

tempfile="test.xml"
csv_string = bank2csv(tempfile)

puts csv_string