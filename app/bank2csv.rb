require 'camt_parser'
require 'csv'
require 'yaml'

class CamtParser::Transaction
  def communication
    ret = @xml_data.xpath('RmtInf/Strd/AddtlRmtInf/text()').text
    ret = @xml_data.xpath('RmtInf/Ustrd/text()').text if ret.empty?
    ret = @xml_data.xpath('AddtlTxInf/text()').text if ret.empty?
    ret = @xml_data.xpath('AddtlRmtInf/text()').text if ret.empty?
    return ret    
  end

  def zreference
    @xml_data.xpath('RmtInf/Strd/CdtrRefInf/Ref/text()').text
  end
end


class ZTransaction
  attr_reader :value_date, :amount, :sign, :info
  attr_accessor :communication, :reference, :name, :iban, :address, :ciccio

  def initialize(_value_date, _amount, _sign, _info)
    @value_date = _value_date
    @amount = _amount.to_f
    @sign = _sign
    @info = _info

    @communication = nil
    @reference = nil
    @name = nil
    @address = nil
    @iban = nil
  end

  def to_hash
    {
      "value_date" => @value_date,
      "amount" => @amount,
      "sign" => @sign,
      "info" => @info,
      "communication" => @communication,
      "reference" => @reference,
      "name" => @name,
      "address" => @address,
      "iban" => @iban,
      "ciccio" => @ciccio,
    }
  end

  def debit
    @sign > 0 ? @amount : 0
  end

  def credit
    @sign < 0 ? @amount : 0
  end

  def self.parse_camt(filename)
    tlist=[]
    camt = CamtParser::File.parse filename
    camt.statements.each_with_index do |stat, istat|
      stat.entries.each_with_index do |entry, ientry|
        if entry.transactions.count == 0
          t = self.new(entry.value_date, entry.amount, entry.sign, entry.additional_information)
          tlist << t
        else
          entry.transactions.each do |tran|
            a = tran.postal_address
            ai = tran.additional_information
            ai = entry.additional_information if ai.empty?
            t = self.new(entry.value_date, tran.amount, tran.sign, entry.additional_information)
            t.communication = tran.communication
            t.reference     = tran.zreference
            t.name          = tran.name
            t.iban          = tran.iban
            t.address       = [
                                 a.lines, a.street_name, a.building_number, 
                                 a.postal_code, a.town_name, a.country
                              ].flatten.join(' ') unless a.nil?
            tlist << t
          end
        end
      end
    end
    return tlist
  end
end

def bank2csv(filename)
  csv_string = CSV.generate do |csv|
    csv << ["date", "montant", "signe", "libelle", "communication", "reference", "nom", "adresse", "IBAN", "231016.175318"]
    ZTransaction.parse_camt(filename).each do |t|
      csv << [
        t.value_date,
        t.amount,
        t.sign,
        t.info,
        t.communication,
        t.reference,
        t.name,
        t.address,
        t.iban,
      ]
    end
  end
  return csv_string
end

def bank2yaml(filename)
  ZTransaction.parse_camt(filename).map{|t| t.to_hash}.to_yaml
end