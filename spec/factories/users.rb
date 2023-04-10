FactoryBot.define do
  factory :user do
    name { Faker::Lorem.words(number: 3).join(' ') }
    sequence(:email) { Faker::Internet.email }
    username { Faker::Internet.username(specifier: 5..10) }
    authentication_token { Faker::Stripe.valid_token }
  end
end
