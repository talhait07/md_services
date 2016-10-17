class Organization::CreateRecipient
  def self.call(organization, type = 'corporation')
    Stripe::Recipient.create(name: organization.name, description: organization.id, type: type)
  end
end
