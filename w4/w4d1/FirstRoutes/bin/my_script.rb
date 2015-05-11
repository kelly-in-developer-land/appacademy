require 'addressable/uri'
require 'rest-client'

def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1.json'
  ).to_s

  puts RestClient.delete(
    url
    # { user: { name: "Examplalalala" } }
  )
end

begin
  create_user
rescue RestClient::Exception => e
  puts "#{e.message}"
end
