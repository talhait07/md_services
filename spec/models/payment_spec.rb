require 'rails_helper'

RSpec.describe Payment, :type => :model do
  let(:payment) { FactoryGirl.create(:payment) }

  # status
  it { should validate_presence_of(:status) }
  it { should allow_value('pending', 'completed', 'failed').for(:status) }
  it { should_not allow_value('not a status').for(:status) }

  # amount
  it { expect(payment).to monetize(:amount) }
  it { expect(payment).not_to monetize(:amount).allow_nil }

  # encounter
  it { should belong_to(:encounter) }

end
