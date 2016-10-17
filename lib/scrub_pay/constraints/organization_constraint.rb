class ScrubPay::Constraints::OrganizationConstraint
  include ScrubPay::Constraints::UserConstraint

  def matches?(request)
    current_user = current_user(request)
    current_user.present? && current_user.organization.present?
  end
end
