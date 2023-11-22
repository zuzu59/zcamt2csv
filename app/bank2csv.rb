require 'camt_parser'
require 'csv'

def bank2csv(filename)
  camt = CamtParser::File.parse filename
  puts camt.group_header.creation_date_time

  csv_string = CSV.generate do |csv|
    csv << ["date", "montant", "signe", "libelle", "communication", "reference", "nom", "adresse", "IBAN", "231016.175318"]
    camt.statements.each do |statement|
      statement.entries.each do |entry|
        address = nil
        # first transaction is used for address, remittance_information, transaction_id, name, iban
        ft=entry.transactions[0]
        postal_address = ft ? ft.postal_address : nil
        if postal_address != nil
          address = [
            postal_address.lines,
            postal_address.street_name,
            postal_address.building_number,
            postal_address.postal_code,
            postal_address.town_name,
            postal_address.country
          ].flatten.join(' ')
        end
        csv << [
          entry.value_date,
          entry.amount.to_f,
          entry.sign,
          entry.additional_information,
          ft ? ft.remittance_information : "NA",
          ft ? ft.transaction_id : "NA",
          ft ? ft.name : "NA", 
          address,          
          ft ? ft.iban : "NA",
        ]
      end
    end
  end
  return csv_string
end
