class Api::V1::Admin::SitesController < Api::V1::ApplicationController

  def validate
    @site = Site.new(params.permit(:name, :address_1, :address_2, :city, :state, :postal_code, :phone_number))

    unless @site.valid?
      error!(:unprocessable_entity, metadata: { details: @site.errors })
    end
  end

end
