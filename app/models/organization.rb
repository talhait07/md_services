class Organization < ActiveRecord::Base

  validates :name, presence: true

  validates :npi_number, presence: true

  validates :positions, presence: true

  validates :address_1, presence: true

  validates :city, presence: true

  validates :state, presence: true

  validates :postal_code, presence: true

  validates :phone_number, presence: true,
                           phony_plausible: true

  phony_normalize :phone_number, default_country_code: 'US'

  validates :url, presence: true


  has_many :organization_users, dependent: :destroy

  has_many :users, through: :organization_users

  has_many :sites, dependent: :destroy

  before_save :create_stripe_recipient, on: :create
  before_destroy :destroy_stripe_recipient

  private
  def create_stripe_recipient
    recipient = Organization::CreateRecipient.call(self)

    self.stripe_recipient_id = recipient.id
  end

  def destroy_stripe_recipient
    Organization::DestroyRecipient.call(self)
  end

end
