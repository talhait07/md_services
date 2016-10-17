class Patient::SetDefaultCard
  def self.call(profile, card_id)
    customer = Patient::GetCustomer.call(profile)
    customer.default_card = card_id
    customer.save
    Patient::GetCard.call(profile, card_id)
  end
end
