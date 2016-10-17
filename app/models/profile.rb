class Profile < ActiveRecord::Base

  validates_associated :user

  validates :birth_date,   presence: true

  validates :phone_number, presence: true,
                           phony_plausible: true

  phony_normalize :phone_number, default_country_code: 'US'

  belongs_to :user

  accepts_nested_attributes_for :user

  before_save :create_stripe_customer, on: :create
  before_destroy :destroy_stripe_customer

  private
  def create_stripe_customer
    customer = Patient::CreateCustomer.call(self)

    self.stripe_id = customer.id
  end

  def destroy_stripe_customer
    Patient::DestroyCustomer.call(self)
  end

end
