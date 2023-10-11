require 'camt_parser'
require 'camt'
camt = CamtParser::File.parse 'CAMT053_101023.xml'
puts camt.group_header.creation_date_time
camt.statements.each do |statement|
    statement.entries.each do |entry|
        # Access individual entries/bank transfers
     #   puts "->"
     puts entry.description
     puts entry.debit
     puts entry.value_date
     p "IBAN: " + entry.transactions[0].iban
     p "ID: " + entry.transactions[0].transaction_id
     puts "IBAN deb:" + entry.transactions[0].debitor.iban
     puts "Detail: " + entry.transactions[0].remittance_information + "\n\n"
    end
end


