#zf231015.1655

require 'sinatra'
require 'fileutils'

require 'camt'
require 'camt_parser'
require 'csv'

get '/' do
  File.read("index.html")
end

post '/' do

  # TODO: check that uploaded (tempfile) is a legitime file
  tempfile = params['file'][:tempfile]

  camt = CamtParser::File.parse tempfile
  puts camt.group_header.creation_date_time

  csv_string = CSV.generate do |csv|
    csv << ["date", "montant", "signe", "libelle", "communication", "reference", "nom", "adresse", "IBAN", "231016.175318"]
    camt.statements.each do |statement|
      statement.entries.each do |entry|
        address = nil
        postal_address = entry.transactions[0].postal_address
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
          entry.amount,
          entry.sign,
          entry.additional_information,
          entry.transactions[0].remittance_information,
          entry.transactions[0].transaction_id,
          entry.transactions[0].name,
          address,          
          entry.transactions[0].iban
        ]
      end
    end
  end

  filename = params['file'][:filename] + ".csv"

  content_type 'application/csv'
  attachment filename

  csv_string
end


# class App
#   def call(env)
#     headers = {
#       'Content-Type' => 'text/html'
#     }

#     req = Rack::Request.new(env)
#     response = 
#       if (req.request_method == "GET")
#         self.index
#       elsif (req.request_method == "POST")
#         self.process(req)
#       else
#         ['<h1>Error!</h1>']
#       end

#     [200, headers, response]
#   end

#   def index
#     []
#   end

#   def process(req)
#     ["<pre>#{req.params.inspect}</pre>"]
#   end
# end
