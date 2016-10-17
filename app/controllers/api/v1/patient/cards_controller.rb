class Api::V1::Patient::CardsController < Api::V1::ApplicationController

  def index
    @cards = ::Patient::GetCards.call(current_user.profile)
  end

  def show
    @card = ::Patient::GetCard.call(current_user.profile, params[:id])
  end

  def create
    error!(:unprocessable_entity, metadata: { details: { card: ['is required'] } }) if params[:card].blank?

    unless @card = ::Patient::AddCard.call(current_user.profile, params[:card])
      # TODO: Localize this response..
      error!(:unprocessable_entity, metadata: { details: 'Unable to add the card to your account' })
    end
  end

  def update
    unless @card = ::Patient::SetDefaultCard.call(current_user.profile, params[:id])
      # TODO: Localize this response..
      error!(:unprocessable_entity, metadata: { details: 'Unable to set card as default on your account' })
    end
  end

  def destroy
    @card = ::Patient::RemoveCard.call(current_user.profile, params[:id])
  end

end
