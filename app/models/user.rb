class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :email, presence: true,
                    format: { with: RFC822::EMAIL },
                    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 8, allow_blank: true },
                       on: :create

  validates :password, length: { minimum: 8, allow_blank: true },
                       confirmation: true,
                       on: :update

  has_one :profile, dependent: :destroy

  has_many :patients, dependent: :destroy
  has_many :sites, through: :patients
  has_many :encounters, through: :patients

  has_one :organization_user
  has_one :organization, through: :organization_user

end
