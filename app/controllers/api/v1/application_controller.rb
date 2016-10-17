class Api::V1::ApplicationController < Api::ApplicationController
  include Errawr::Rails.with_renderer(Errawr::Rails::Renderers::JSON)

  private
  def current_user
    if doorkeeper_token && doorkeeper_token.resource_owner_id
      @current_user ||= User.find_by_id(doorkeeper_token.resource_owner_id)
    else
      error!(:unauthorized)
    end
  end

  def current_organization
    @current_organization ||= current_user.organization
  end

  #def current_role
  #  @current_role ||= current_user.role
  #end

  #def current_employer
  #  @current_employer ||= current_role.roleable
  #end

  def doorkeeper_unauthorized_render_options
    {
      json: {
        error: 'unauthorized',
        description: 'Unauthorized'
      }
    }
  end
end
