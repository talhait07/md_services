FactoryGirl.define do
  factory :patient do
    association(:site, factory: :site)
    association(:user, factory: :user)
  end

end
