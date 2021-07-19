module ResponsePatterns
  UNAUTHORIZED = {
    "error_code" => "auth_failed",
    "error_messages" => {
      "username" => [{
        "code" => "invalid_supplied_credentials",
        "message" => "Authentication failed with the supplied credentials",
        "params" => {}
      }]
    }
  }.freeze

  INVALID_BANK_COUNTRY={
    "error_code" => "beneficiary_create_failed",
    "error_messages" => {
      "bank_country" => [{
        "code" => "bank_country_is_in_invalid_format",
        "message" => "bank_country is not a valid ISO 3166-1 Alpha-2 country code",
        "params" => {
          "type" => "country_code"
        }
      }]
    }
  }.freeze
  
  MISSING_CURRENCY={
    "error_code" => "beneficiary_create_failed",
    "error_messages" => {
      "currency" => [{
        "code" => "currency_is_in_invalid_format",
        "message" => "currency is in invalid format",
        "params" => {}
      }]
    }
  }.freeze
end
