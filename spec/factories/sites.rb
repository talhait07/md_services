# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site do
    association(:organization, factory: :organization)

    name 'Biff Medical & Stuff'
    address_1 '1234 Main St.'
    city 'Kokomo'
    state 'IN'
    postal_code '46901'
    phone_number '3332221111'
  end
end
