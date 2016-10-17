class Api::V1::Organization::SitesController < Api::V1::ApplicationController

  def index
    @sites = current_organization.sites.page(params[:page]).order(params[:order] || 'name')
  end

  def show
    @site = current_organization.sites.find(params[:id])
  end

  def create
    @site = current_organization.sites.new(params.permit(:name, :address_1, :address_2, :city, :state, :postal_code, :phone_number))

    unless @site.save
      error!(:unprocessable_entity, metadata: { details: @site.errors })
    end
  end

  def update
    @site = current_organization.sites.find(params[:id])

    unless @site.update_attributes(params.permit(:name, :address_1, :address_2, :city, :state, :postal_code, :phone_number))
      error!(:unprocessable_entity, metadata: { details: @site.errors })
    end
  end

  def destroy
    @site = current_organization.sites.find(params[:id])

    @site.destroy
  end

end
