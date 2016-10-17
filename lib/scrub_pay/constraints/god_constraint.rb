class ScrubPay::Constraints::GodConstraint
  include ScrubPay::Constraints::UserConstraint

  def matches?(request)
    current_user = current_user(request)
    current_user.present? && current_user.god?
  end
end
