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
    csv << ["id", "debit", "value_date", "iban", "deb iban", "description", "details"]
    camt.statements.each do |statement|
      statement.entries.each do |entry|
        csv << [
          entry.transactions[0].transaction_id,
          entry.debit,
          entry.value_date,
          entry.transactions[0].iban,
          entry.transactions[0].debitor.iban,
          entry.description,
          entry.transactions[0].remittance_information,
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
