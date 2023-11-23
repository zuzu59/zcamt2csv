require 'yaml'
require "./#{File.dirname(__FILE__)}/bank2csv.rb"

fn=ARGV.first

xmlfile = fn+".xml"
xmlfile = "test/real/#{fn}.xml" unless File.exists?(xmlfile)

puts bank2csv(xmlfile)
# puts bank2yaml(xmlfile)
