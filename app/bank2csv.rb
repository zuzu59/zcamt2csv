require 'camt_parser'
require 'csv'

class CamtParser::Transaction
  def communication
    ret = @xml_data.xpath('RmtInf/Strd/AddtlRmtInf/text()').text
    ret = @xml_data.xpath('RmtInf/Ustrd/text()').text if ret.empty?
    ret = @xml_data.xpath('AddtlTxInf/text()').text if ret.empty?
    return ret    
  end

  def zreference
    ret = @xml_data.xpath('RmtInf/Strd/CdtrRefInf/Ref/text()').text
  end
end


def bank2csv(filename)
  camt = CamtParser::File.parse filename
  puts camt.group_header.creation_date_time

  csv_string = CSV.generate do |csv|
    csv << ["date", "montant", "signe", "libelle", "communication", "reference", "nom", "adresse", "IBAN", "231016.175318"]
    camt.statements.each_with_index do |stat, istat|
      stat.entries.each_with_index do |entry, ientry|
        if entry.transactions.count == 0
          csv << [
            entry.value_date,
            entry.amount.to_f,
            entry.sign,
            entry.additional_information,
            nil,
            nil,
            nil,
            nil,
            nil,
          ]          
        end
        entry.transactions.each_with_index do |tran, itran|
          address = nil
          # first transaction is used for address, remittance_information, transaction_id, name, iban
          postal_address = tran ? tran.postal_address : nil
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
            tran.amount.to_f,
            tran.sign,
            tran.additional_information,
            tran.communication,
            # tran ? tran.remittance_information : "NA",
            tran.zreference,
            tran ? tran.name : "NA", 
            address,          
            tran ? tran.iban : "NA",
          ]
          # puts "  tran #{itran}:"
          # puts "    info:       #{tran.communication}"
          # puts "    value_date: #{entry.value_date}"
          # puts "    amount:     #{tran.amount.to_f}"
          # puts "    sign:       #{tran.sign}"
        end

      end
    end
  end
  return csv_string
end
