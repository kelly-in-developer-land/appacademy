require 'addressable/uri'
require 'rest-client'

def test_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1.json'
  ).to_s

  puts RestClient.patch(
    url,
    { user: { username: 'User2' } }
  )
end


def test_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/2.json'
  ).to_s

  puts RestClient.patch(
    url,
    { contact: { email: 'contact1@example.com' } }
  )
end

test_contact

# begin
# rescue RestClient::Exception => e
#   p e
# end
#
# begin
#   test_user
# rescue RestClient::Exception => e
#   puts "#{e.message}"
# end
