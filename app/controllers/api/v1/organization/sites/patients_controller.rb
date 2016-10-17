class Api::V1::Organization::Sites::PatientsController < Api::V1::ApplicationController

  def index
    site = current_organization.sites.find(params[:site_id])

    if params[:q]
      @patients = Patient.search({ query: { query_string: { query: params[:q] }}, filter: { term: { site_id: site.id } } }).records
    else
      @patients = site.patients
    end

    @patients = @patients.eager_load(:user).order(params[:order] || 'users.first_name').page(params[:page])
  end

  def show
    site = current_organization.sites.find(params[:site_id])
    @patient = site.patients.find(params[:id])
  end

  def destroy
    site = current_organization.sites.find(params[:site_id])
    @patient = site.patients.find(params[:id])

    @patient.destroy
  end

end
