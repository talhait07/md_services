class Api::V1::Admin::Organizations::SitesController < Api::V1::ApplicationController

  def index
    organization = Organization.find(params[:organization_id])
    @sites = organization.sites.page(params[:page]).order(params[:order] || 'name')
  end

  def show
    organization = Organization.find(params[:organization_id])
    @site = organization.sites.find(params[:id])
  end

  def create
    organization = Organization.find(params[:organization_id])
    @site = organization.sites.new(params.permit(:name, :address_1, :address_2, :city, :state, :postal_code, :phone_number))

    #if @site.valid?
    #  @site.save unless params[:validate]
    #else
    unless @site.save
      error!(:unprocessable_entity, metadata: { details: @site.errors })
    end
  end

  def update
    organization = Organization.find(params[:organization_id])
    @site = organization.sites.find(params[:id])

    unless @site.update_attributes(params.permit(:name, :address_1, :address_2, :city, :state, :postal_code, :phone_number))
      error!(:unprocessable_entity, metadata: { details: @site.errors })
    end
  end

  def destroy
    organization = Organization.find(params[:organization_id])
    @site = organization.sites.find(params[:id])

    @site.destroy
  end

end
