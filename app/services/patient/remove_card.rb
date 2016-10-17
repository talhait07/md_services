class Patient::RemoveCard
  def self.call(profile, card_id)
    Patient::GetCard.call(profile, card_id).delete
  end
end
