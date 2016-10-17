class Patient::GetCard
  def self.call(profile, card_id)
    customer = Patient::GetCustomer.call(profile)
    card = customer.cards.retrieve(card_id)
    card[:is_default] = customer.default_card.eql?(card[:id])

    card
  end
end
