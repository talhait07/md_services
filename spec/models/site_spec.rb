require 'rails_helper'

RSpec.describe Site, :type => :model do

  # name
  it { should validate_presence_of(:name) }

  # address_1
  it { should validate_presence_of(:address_1) }

  # city
  it { should validate_presence_of(:city) }

  # state
  it { should validate_presence_of(:state) }

  # postal_code
  it { should validate_presence_of(:postal_code) }

  # phone_number
  it { should validate_presence_of(:phone_number) }
  it { should allow_value('(555) 555 5555').for(:phone_number) }
  it { should_not allow_value('not a phone number').for(:phone_number) }

  # organization
  it { should belong_to(:organization) }

  # encounters
  it { should have_many(:encounters).dependent(:destroy) }

  # patients
  it { should have_many(:patients).dependent(:destroy) }

  # users
  it { should have_many(:users).through(:patients) }

end
