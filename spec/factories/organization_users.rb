# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization_user do
    association(:organization, factory: :organization)
    association(:user, factory: :user)
  end
end
