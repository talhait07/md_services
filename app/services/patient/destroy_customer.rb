class Patient::DestroyCustomer
  def self.call(profile)
    Patient::GetCustomer.call(profile).delete
  end
end
