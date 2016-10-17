class Api::V1::Admin::OrganizationsController < Api::V1::ApplicationController

  def index
    @organizations = ::Organization.page(params[:page]).order(params[:order] || 'name')
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def create
    @organization = ::Organization.new(params.permit(:name, :npi_number, :positions, :address_1, :address_2, :city, :state, :postal_code, :phone_number, :url))

    if @organization.valid?
      @organization.save unless params[:validate]
    else
      error!(:unprocessable_entity, metadata: { details: @organization.errors })
    end
  end

  def update
    @organization = Organization.find(params[:id])

    unless @organization.update_attributes(params.permit(:name, :npi_number, :positions, :address_1, :address_2, :city, :state, :postal_code, :phone_number, :url))
      error!(:unprocessable_entity, metadata: { details: @organization.errors })
    end
  end

  def destroy
    @organization = Organization.find(params[:id])

    @organization.destroy
  end

end
