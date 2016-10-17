require 'rails_helper'

RSpec.describe Patient, :type => :model do
  # user
  it { subject = FactoryGirl.create(:patient); should validate_uniqueness_of(:user_id).scoped_to([:site_id]) }
  it { should belong_to(:user) }

  # site
  it { should belong_to(:site) }

  # encounters
  it { should have_many(:encounters).dependent(:destroy) }
end
