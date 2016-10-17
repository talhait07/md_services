require 'csv'

class Encounter < ActiveRecord::Base
  include ScrubPay::Search::EncounterIndexer

  monetize :balance_cents, :allow_nil => false

  monetize :paid_cents

  monetize :remaining_balance_cents

  validates :status, presence: true,
                     inclusion: { in: %w(open paid) }

  validates :first_name, presence: true

  validates :last_name, presence: true

  validates :birth_date, presence: true

  validates :phone_number, presence: true,
                           phony_plausible: true

  phony_normalize :phone_number, default_country_code: 'US'

  has_many :payments, dependent: :destroy

  belongs_to :site

  belongs_to :patient

  after_touch :update_status

  def paid_cents
    payments.completed.sum(:amount_cents)
  end

  def remaining_balance_cents
    balance_cents - paid_cents
  end

  def self.to_csv(options = {})
    helpers = ActionController::Base.helpers

    CSV.generate(options) do |csv|
      csv << ["id", "date", "status", "first_name", "last_name", "birth_date", "phone_number", "balance", "remaining_balance"]
      all.each do |encounter|
        csv << [encounter.id, encounter.created_at, encounter.status, encounter.first_name, encounter.last_name, encounter.birth_date, encounter.phone_number, helpers.humanized_money(encounter.balance), helpers.humanized_money(encounter.remaining_balance)]
      end
    end
  end

  private
  def update_status
    update_attribute(:status, 'paid') if status.eql?('open') && remaining_balance <= 0
  end
end
