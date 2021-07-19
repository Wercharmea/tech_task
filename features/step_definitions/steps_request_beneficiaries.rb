##
# Create beneficiary

require './support/helpers'
require './support/response_patterns'

Given(/^valid user gets an auth token$/) do
  form_data = {
    'login_id' => ENV['LOGIN_ID'],
    'api_key' => ENV['API_KEY']
  }
  response = API_CLIENT.post_token(form_data)
  token = JSON.parse(response.body).dig('auth_token')
  STORE.save(:token, token)
end

When(/^creating beneficiary '(\S*)' with:$/) do |key, table|
 form_data = table.to_hash
 token = STORE.fetch(:token)
 response = API_CLIENT.post_beneficiary(form_data, token)
 STORE.save(key, response)
end

When(/^creating beneficiary '(\S*)' without token$/) do |key|
  response = API_CLIENT.post_beneficiary({},nil)
  STORE.save(key, response)
end

Then(/^'(\S*)' response code should be (\d+)$/) do |key, status|
  response = STORE.fetch(key)
  expect(response.code.to_i).to eq(status)
end

And (/^the '(\S*)' response body matches pattern '(\S*)'$/) do |key, pattern_key|
  response = STORE.fetch(key)
  body = JSON.parse(response.body)
  pattern = "ResponsePatterns::#{pattern_key}".constantize
  expect(body).to include(pattern)
end
