# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :encounter do
    association(:site, factory: :site)
    status 'open'
    first_name 'Biff'
    last_name 'Imbierowicz'
    birth_date '2000-12-31'
    phone_number '4444444444'
    balance 100.00
  end
end
