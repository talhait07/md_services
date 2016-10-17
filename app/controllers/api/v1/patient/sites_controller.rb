class Api::V1::Patient::SitesController < Api::V1::ApplicationController

  def index
    @sites = current_user.sites.order(params[:order] || 'name')#.page(params[:page])
  end

  def show
    @site = current_user.sites.find(params[:id])
  end

  def create
    @site = Site.find_by(site_number: params[:site_number])
    error!(:unprocessable_entity, metadata: { details: { site_number: ['Unable to find your site. Please contact your healthcare provider.'] } }) unless @site

    patient = current_user.patients.new(site: @site)

    unless patient.save
      error!(:unprocessable_entity, metadata: { details: patient.errors })
    end
  end

end
