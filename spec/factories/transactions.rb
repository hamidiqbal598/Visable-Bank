FactoryBot.define do
  factory :transaction do
    amount { Faker::Number.decimal(l_digits: 2) }
    purpose { Faker::Lorem.paragraph }
    sender { sender }
    recipient { recipient }
    account_sender { account_sender }
    account_recipient { account_recipient }
  end
end
