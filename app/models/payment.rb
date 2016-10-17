class Payment < ActiveRecord::Base

  monetize :amount_cents, :allow_nil => false

  validates :status, presence: true,
                     inclusion: { in: %w(pending completed failed) }

  validate  :require_valid_amount

  belongs_to :encounter, touch: true

  def self.completed
    where{status.eq('completed')}
  end

  private
  def require_valid_amount
    if encounter
      remaining_balance = encounter.remaining_balance

      if amount == 0 || amount != remaining_balance
        errors.add(:amount, 'must equal the remaining balance')
      end
    end
  end

end
