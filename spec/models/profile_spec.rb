require 'rails_helper'

RSpec.describe Profile, :type => :model do

  # birth_date
  it { should validate_presence_of(:birth_date) }

  # phone_number
  it { should validate_presence_of(:phone_number) }
  it { should allow_value('5555555555').for(:phone_number) }
  it { should_not allow_value('not a phone number').for(:phone_number) }

  # user
  it { should belong_to(:user) }

end
