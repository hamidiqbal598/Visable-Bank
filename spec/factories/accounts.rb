FactoryBot.define do
  factory :account do
    user
    account_type { POSSIBLE_TYPE_OF_ACCOUNTS.sample }
    account_number { Faker::Bank.iban }
    balance { Faker::Number.decimal(l_digits: 2) }
  end
end
