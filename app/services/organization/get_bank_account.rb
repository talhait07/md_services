class Organization::GetBankAccount
  def self.call(organization)
    recipient = Organization::GetRecipient.call(organization)
    recipient[:active_account]
  end
end
