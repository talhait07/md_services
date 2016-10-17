class Organization::DestroyRecipient
  def self.call(organization)
    Organization::GetRecipient.call(organization).delete
  end
end
