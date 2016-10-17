def setup_oauth2
  let(:token) { double :acceptable? => true, :accessible? => true, :application_id => SecureRandom.uuid, :resource_owner_id => SecureRandom.uuid }

  before(:each) do
    allow(controller).to receive(:doorkeeper_token) { token }
  end
end

def require_oauth2(&block)
  allow(controller).to receive(:doorkeeper_token) { nil }
  yield(block)
  expect(response.header['WWW-Authenticate']).to match(/error=\"invalid_token\"/)
end

def generate_oauth2_application(resource_owner_id = nil)
  @application = Doorkeeper::Application.create!(name: SecureRandom.hex, redirect_uri: 'http://www.example.com')
  @access_token = Doorkeeper::AccessToken.create!(application: @application, resource_owner_id: resource_owner_id)
end
