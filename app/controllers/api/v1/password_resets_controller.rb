class Api::V1::PasswordResetsController < Api::V1::ApplicationController
  def create
    user = User.find_by_email(params[:email])

    user.deliver_reset_password_instructions! if user

    render json: 'successful'
  end

  def update
    token = params[:id]
    user = User.load_from_reset_password_token(token)

    if user.blank?
      error!(:unauthorized)
    end

    password_reset_form = PasswordResetForm.new(params.permit(:password, :password_confirmation))

    if password_reset_form.valid?
      user.change_password!(password_reset_form.password)

      @access_token = Doorkeeper::AccessToken.create!(
      resource_owner_id: user.id,
      application_id: doorkeeper_token.application_id,
      use_refresh_token: Doorkeeper.configuration.refresh_token_enabled?,
      expires_in: Doorkeeper.configuration.access_token_expires_in
      )
    else
      error!(:unprocessable_entity, metadata: { details: password_reset_form.errors })
    end
  end
end
