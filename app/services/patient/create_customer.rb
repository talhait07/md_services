class Patient::CreateCustomer
  def self.call(profile)
    Stripe::Customer.create(description: profile.user.id)
  end
end
