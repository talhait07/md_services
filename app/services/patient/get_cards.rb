class Patient::GetCards
  def self.call(profile)
    customer = Patient::GetCustomer.call(profile)
    cards = customer.cards

    cards.each do |card|
      card[:is_default] = customer.default_card.eql?(card[:id])
    end

    cards
  end
end
