require 'dotenv'
require 'pry'
require_relative './api_client'
require_relative './store'

Dotenv.load('.env')

API_CLIENT = ApiClient.new
STORE = Store.new
