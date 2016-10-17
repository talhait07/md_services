class Api::V1::Patient::EncountersController < Api::V1::ApplicationController

  def index
    @encounters = current_user.encounters.order(params[:order] || 'created_at').page(params[:page])
  end

  def show
    @encounter = current_user.encounters.find(params[:id])
  end

end
