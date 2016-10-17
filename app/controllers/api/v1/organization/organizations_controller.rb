class Api::V1::Organization::OrganizationsController < Api::V1::ApplicationController

  def show
    @organization = current_organization
  end

  def update
    @organization = current_organization

    unless @organization.update_attributes(params.permit(:name, :npi_number, :positions, :address_1, :address_2, :city, :state, :postal_code, :phone_number, :url))
      error!(:unprocessable_entity, metadata: { details: @organization.errors })
    end
  end

end
