require 'rails_helper'

RSpec.describe Encounter, :type => :model do
  let(:encounter) { FactoryGirl.create(:encounter) }

  # status
  it { should validate_presence_of(:status) }
  it { should allow_value('open', 'paid').for(:status) }
  it { should_not allow_value('not a status').for(:status) }

  # first_name
  it { should validate_presence_of(:first_name) }

  # last_name
  it { should validate_presence_of(:last_name) }

  # birth_date
  it { should validate_presence_of(:birth_date) }

  # phone_number
  it { should validate_presence_of(:phone_number) }
  it { should allow_value('(555) 555 5555').for(:phone_number) }
  it { should_not allow_value('not a phone number').for(:phone_number) }

  # balance
  it { expect(encounter).to monetize(:balance_cents) }
  it { expect(encounter).not_to monetize(:balance_cents).allow_nil }

  # payments
  it { should have_many(:payments).dependent(:destroy) }

  # site
  it { should belong_to(:site) }

  # patient
  it { should belong_to(:patient) }

end
