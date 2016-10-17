class Api::V1::Organization::UsersController < Api::V1::ApplicationController

  def index
    @users = current_organization.users.page(params[:page]).order(params[:order] || 'first_name')
  end

  def show
    @user = current_organization.users.find(params[:id])
  end

  def create
    organization_user = current_organization.organization_users.build
    @user = organization_user.build_user(params.permit(:first_name, :last_name, :email))

    organization_user.roles = { billing: true } if params[:billing] == true

    if organization_user.save
      # Todo: Send the welcome email here..
    else
      error!(:unprocessable_entity, metadata: { details: @user.errors })
    end
  end

  def update
    @user = current_organization.users.find(params[:id])

    unless @user.update_attributes(params.permit(:first_name, :last_name, :email))
      error!(:unprocessable_entity, metadata: { details: @user.errors })
    end
  end

  def destroy
    @user = current_organization.users.find(params[:id])

    error!(:bad_request) if current_user.eql?(@user)

    @user.organization_user.destroy
  end

end
