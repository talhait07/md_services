# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do

    name 'Biff Medical Enterprise'
    npi_number '123hada1'
    positions 130
    address_1 '1233 Main St.'
    city 'Kokomo'
    state 'IN'
    postal_code '46901'
    phone_number '3332221111'
    url 'http://biffmedical.com'
  end
end
