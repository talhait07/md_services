module ScrubPay
  module Constraints
    module UserConstraint
      def current_user(request)
        #User.find_by_id(request.session[:user_id])
        token = Doorkeeper::OAuth::Token.authenticate(request, *Doorkeeper.configuration.access_token_methods)
        User.find_by_id(token.resource_owner_id) if token && token.acceptable?(nil)
      end
    end
  end
end
