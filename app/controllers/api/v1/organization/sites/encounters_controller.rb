class Api::V1::Organization::Sites::EncountersController < Api::V1::ApplicationController

  def index
    site = current_organization.sites.find(params[:site_id])

    if params[:q]
      @encounters = Encounter.search({ query: { query_string: { query: params[:q] }}, filter: { term: { site_id: site.id } } }).records
    else
      @encounters = site.encounters
    end

    @encounters = @encounters.order(params[:order] || 'first_name').page(params[:page])
  end

  def download
    site = current_organization.sites.find(params[:site_id])
    encounters = site.encounters.order(params[:order] || 'created_at desc')
    send_data encounters.to_csv
  end

  def show
    site = current_organization.sites.find(params[:site_id])
    @encounter = site.encounters.find(params[:id])
  end

  def destroy
    site = current_organization.sites.find(params[:site_id])
    @encounter = site.encounters.find(params[:id])

    @encounter.destroy
  end

end
