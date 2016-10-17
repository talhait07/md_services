require 'rails_helper'

RSpec.describe Organization, :type => :model do

  # name
  it { should validate_presence_of(:name) }

  # npi_number
  it { should validate_presence_of(:npi_number) }

  # positions
  it { should validate_presence_of(:positions) }

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

  # url
  it { should validate_presence_of(:url) }

  # organization_users
  it { should have_many(:organization_users) }

  # users
  it { should have_many(:users).through(:organization_users) }

  # sites
  it { should have_many(:sites) }

end
