FactoryGirl.define do
  factory :profile do
    association(:user, factory: :user)

    birth_date   '2000-09-12'
    phone_number '3332221111'
  end

end
