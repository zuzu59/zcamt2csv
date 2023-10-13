require 'rack'
require_relative './app'

use Rack::Reloader, 0 if ENV['RELOADER']
if ENV['RELOADER']
  puts "USING RELOADER"
end
run App.new
