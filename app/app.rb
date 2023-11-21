#zf231015.1655

require 'sinatra'
require 'fileutils'

require './bank2csv.rb'

get '/' do
  File.read("index.html")
end

post '/' do

  # TODO: check that uploaded (tempfile) is a legitime file
  tempfile = params['file'][:tempfile]

  csv_string = bank2csv(tempfile)

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
