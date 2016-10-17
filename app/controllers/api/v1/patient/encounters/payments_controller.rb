class Api::V1::Patient::Encounters::PaymentsController < Api::V1::ApplicationController

  def index
    encounter = current_user.encounters.find(params[:encounter_id])
    @payments = encounter.payments
  end

  def show
    encounter = current_user.encounters.find(params[:encounter_id])
    @payment = encounter.payments.find(params[:id])
  end

  def create
    encounter = current_user.encounters.find(params[:encounter_id])
    @payment = encounter.payments.new(params.permit(:amount))

    error!(:unprocessable_entity, metadata: { details: @payment.errors }) unless @payment.valid?

    begin
      Encounter::Charge.call(@payment, params[:card_id])
    rescue => e
      error!(:unprocessable_entity, metadata: { message: e })
    end
  end

end
