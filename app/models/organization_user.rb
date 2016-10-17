class OrganizationUser < ActiveRecord::Base

  store_accessor :roles, :admin

  validates :organization_id, uniqueness: { scope: [:user_id] }

  validates :status, presence: true,
                     inclusion: { in: %w(active suspended) }

  belongs_to :organization, counter_cache: true
  belongs_to :user, dependent: :destroy

  accepts_nested_attributes_for :user

  def admin
    return (super == 'true') if %w{true false}.include? super
    return false if super.blank?
    super
  end
end
