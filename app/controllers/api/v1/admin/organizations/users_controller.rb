class Api::V1::Admin::Organizations::UsersController < Api::V1::ApplicationController

  def index
    organization = Organization.find(params[:organization_id])
    @users = organization.users.page(params[:page]).order(params[:order] || 'first_name')
  end

  def create
    organization = Organization.find(params[:organization_id])
    organization_user = organization.organization_users.build
    @user = organization_user.build_user(params.permit(:first_name, :last_name, :email))

    organization_user.roles = { admin: true }

    if organization_user.save
      # We need to send an email notification here
    else
      error!(:unprocessable_entity, metadata: { details: @user.errors })
    end
  end

  def destroy
    organization = Organization.find(params[:organization_id])
    @user = organization.users.find(params[:id])

    @user.organization_user.destroy
  end

end
