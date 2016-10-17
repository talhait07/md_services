require 'rails_helper'

RSpec.describe OrganizationUser, :type => :model do

  # status
  it { should validate_presence_of(:status) }
  it { should allow_value('active').for(:status) }
  it { should allow_value('suspended').for(:status) }
  it { should_not allow_value(SecureRandom.hex).for(:status) }

  # organization
  it { subject = FactoryGirl.create(:organization_user); should validate_uniqueness_of(:organization_id).scoped_to([:user_id]) }
  it { should belong_to(:organization) }

  # user
  it { should belong_to(:user) }

end
