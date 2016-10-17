FactoryGirl.define do
  factory :payment do
    association(:encounter, factory: :encounter)

    status 'completed'
    amount 100.00

    factory :payment_as_failed do
      status 'failed'
    end
  end

end
