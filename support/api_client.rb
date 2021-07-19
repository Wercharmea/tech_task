require "uri"
require "net/http"
require "json"
require "pry"

class ApiClient
  BASE_URL = 'https://devapi.currencycloud.com'.freeze
  AUTH_PATH = '/v2/authenticate/api'.freeze
  BENEFICIARY_PATH = '/v2/beneficiaries/create'.freeze

  def initialize
    url = URI(BASE_URL)
    @connection = Net::HTTP.new(url.host, url.port)
    @connection.use_ssl = true
  end

 def post_token(form_data)
   content_type = 'multipart/form-data'
   request = Net::HTTP::Post.new(AUTH_PATH)
   request.set_form(form_data.to_a, content_type)
   response = @connection.request(request)

   response
 end

 def post_beneficiary(form_data, token)
   content_type = 'multipart/form-data'
   request = Net::HTTP::Post.new(BENEFICIARY_PATH)
   request["Content-Type"] = content_type
   request["X-Auth-Token"] = token
   request.set_form(form_data.to_a, content_type)
   response = @connection.request(request)

   response
 end
end
