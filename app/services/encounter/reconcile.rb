class Encounter::Reconcile

  def self.call(encounter, row)
    balance = row[:balance]

    if encounter.remaining_balance > balance
      # Since the balance is lower, we are assumming a payment was made at the office.
      amount = encounter.remaining_balance - balance
      encounter.payments.create(amount: amount, status: 'completed')
    elsif encounter.remaining_balance < balance
      encounter.errors.add(:balance, 'is higher than the remaining balance')
    end
  end
end
