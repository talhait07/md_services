class Patient < ActiveRecord::Base
  include ScrubPay::Search::PatientIndexer

  validates :user_id, uniqueness: { scope: [:site_id] }

  belongs_to :user

  belongs_to :site

  has_many :encounters, dependent: :destroy

end
