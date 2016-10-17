class Site < ActiveRecord::Base

  validates :name, presence: true

  validates :address_1, presence: true

  validates :city, presence: true

  validates :state, presence: true

  validates :postal_code, presence: true

  validates :phone_number, presence: true,
                           phony_plausible: true

  phony_normalize :phone_number, default_country_code: 'US'

  belongs_to :organization, counter_cache: true

  has_many :encounters, dependent: :destroy

  has_many :patients, dependent: :destroy
  has_many :users, through: :patients

  before_create :generate_site_number

  private
  def generate_site_number
    self.site_number = loop do
      random_number = rand(10000000..99999999).to_s
      break random_number unless Site.exists?(site_number: random_number)
    end
  end

end
