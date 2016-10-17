class Api::V1::Organization::AccountsController < Api::V1::ApplicationController

  def show
    @account = ::Organization::GetBankAccount.call(current_organization)
    render json: nil unless @account
  end

  def update
    @account = ::Organization::SetBankAccount.call(current_organization, params[:account])
  end

end
