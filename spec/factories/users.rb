# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name 'Biff'
    last_name 'Imbierowicz'
    sequence(:email) { |n| "#{n}@scrubpay.com" }
    password 'password'

    factory :user_as_admin do
      god true
    end

  end
end
