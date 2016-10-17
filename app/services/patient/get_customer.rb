class Patient::GetCustomer
  def self.call(profile)
    Stripe::Customer.retrieve(profile.stripe_id)
  end
end
