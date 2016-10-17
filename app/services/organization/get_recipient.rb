class Organization::GetRecipient
  def self.call(organization)
    Stripe::Recipient.retrieve(organization.stripe_recipient_id)
  end
end
