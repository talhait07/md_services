require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { FactoryGirl.build(:user) }

  # first_name
  it { should validate_presence_of(:first_name) }

  # last_name
  it { should validate_presence_of(:last_name) }

  # email
  it { should validate_presence_of(:email) }
  it { should allow_value('biff@scrubpay.com').for(:email) }
  it { should_not allow_value('scrubpay').for(:email) }
  it { subject.save!; should validate_uniqueness_of(:email) }

  # password
  it { should allow_value('').for(:password) }
  it { should allow_value(nil).for(:password) }
  it { should ensure_length_of(:password).is_at_least(8) }

  # profile
  it { should have_one(:profile).dependent(:destroy) }

  # patients
  it { should have_many(:patients).dependent(:destroy) }

  # sites
  it { should have_many(:sites).through(:patients) }

  # organization_user
  it { should have_one(:organization_user) }

  # organization
  it { should have_one(:organization).through(:organization_user) }

end
