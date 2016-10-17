def expect_validation_error(&block)
  yield(block)

  expect(response.body).to match(/^{"error":"unprocessable_entity","description":"Unprocessable Entity","details":{.+}}$/)
end

def expect_bad_request_error(&block)
  yield(block)

  expect(response.body).to match(/^{"error":"bad_request","description":"Bad Request"}$/)
end

#def setup_current_user(user, role)
#  before(:each) do
#    @user = user
#    @role = role
#
#    allow(controller).to receive(:current_user) { user }
#    allow(user).to receive(:role) { role }
#  end
#end

def version
  'application/vnd.scrubpay.com; version=1'
end
