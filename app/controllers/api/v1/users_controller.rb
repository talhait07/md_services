class Api::V1::UsersController < Api::V1::ApplicationController

  def show
    @user = current_user
  end

  def create
    profile = Profile.new(params.permit(:birth_date, :phone_number))
    user = profile.build_user(params.permit(:first_name, :last_name, :email, :password))

    if profile.save
      @access_token = Doorkeeper::AccessToken.create!(
        resource_owner_id: user.id,
        application_id: doorkeeper_token.application_id,
        use_refresh_token: Doorkeeper.configuration.refresh_token_enabled?,
        expires_in: Doorkeeper.configuration.access_token_expires_in
      )
    else
      error!(:unprocessable_entity, metadata: { details: profile.errors })
    end
  end

  def update
    @user = current_user

    unless @user.update_attributes(params.permit(:first_name, :last_name, :email, :password, :password_confirmation))
      error!(:unprocessable_entity, metadata: { details: @user.errors })
    end
  end

  def validate
    @user = User.new(params.permit(:first_name, :last_name, :email))

    unless @user.valid?
      error!(:unprocessable_entity, metadata: { details: @user.errors })
    end
  end

end
