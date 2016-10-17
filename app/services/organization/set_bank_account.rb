class Organization::SetBankAccount
  def self.call(organization, account_id)
    recipient = Organization::GetRecipient.call(organization)
    recipient.bank_account = account_id
    recipient.save
    recipient[:active_account]
  end
end
