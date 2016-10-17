class Api::V1::Admin::UsersController < Api::V1::ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    unless @user.update_attributes(params.permit(:first_name, :last_name, :email))
      error!(:unprocessable_entity, metadata: { details: @user.errors })
    end
  end

end
