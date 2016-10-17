class Patient::AddCard
  def self.call(profile, card)
    customer = Patient::GetCustomer.call(profile)
    customer.cards.create(card: card)
  end
end
