Feature: Create new beneficiary

  # Either it`s a bug, or documentation is outdated
  Scenario: Creating a new beneficiary with valid request parameters, required parameters only

    Given valid user gets an auth token
    When creating beneficiary 'beneficiary-valid' with:
      | name                     | John Doe |
      | bank_account_holder_name | John Doe |
      | bank_country             | UA       |
      | currency                 | UAH      |
    Then 'beneficiary-valid' response code should be 200

  Scenario: Creating a new beneficiary with valid request parameters, required and optional

    Given valid user gets an auth token
    When creating beneficiary 'beneficiary-valid-extended' with:
      # required
      | name                     | John Doe    |
      | bank_account_holder_name | John Doe    |
      | bank_country             | UA          |
      | currency                 | UAH         |
      # optional
      | beneficiary_address      | any         |
      | beneficiary_country      | UA          |
      | account_number           | 123         |
      | bic_swift                | CITIUS33AAA |
      | bank_address             | any         |
      | beneficiary_entity_type  | individual  |
      | beneficiary_first_name   | joe         |
      | beneficiary_last_name    | doe         |
      | beneficiary_city         | any         |
    Then 'beneficiary-valid-extended' response code should be 200
    # And the 'beneficiary-valid-extended' response body matches pattern 'BENEFECIARY'

  Scenario: Creating a new beneficiary without token

   When creating beneficiary 'unauthorized' without token
   Then 'unauthorized' response code should be 401
   And the 'unauthorized' response body matches pattern 'UNAUTHORIZED'

  Scenario: Creating a new beneficiary, invalid bank country

    Given valid user gets an auth token
    When creating beneficiary 'beneficiary-invalid-bank-country' with:
     | name                     | John Doe |
     | bank_account_holder_name | John Doe |
     | bank_country             | Ukraine  |
     | currency                 | UAH      |
   Then 'beneficiary-invalid-bank-country' response code should be 400
   And the 'beneficiary-invalid-bank-country' response body matches pattern 'INVALID_BANK_COUNTRY'

  Scenario Outline: Creating a new beneficiary, missing currency field

   Given valid user gets an auth token
   When creating beneficiary 'beneficiary-missing-currency' with:
    | name                     | John Doe |
    | bank_account_holder_name | John Doe |
    | bank_country             | UA       |
    | currency                 |          |
   Then 'beneficiary-missing-currency' response code should be 400
   And the 'beneficiary-missing-currency' response body matches pattern 'MISSING_CURRENCY'
