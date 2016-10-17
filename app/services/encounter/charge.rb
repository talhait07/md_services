class Encounter::Charge
  def self.call(payment, card = nil)
    encounter = payment.encounter
    profile = encounter.patient.user.profile
    charge = Stripe::Charge.create(amount: payment.amount.cents, currency: payment.amount.currency.iso_code, customer: profile.stripe_id, card: card, capture: true, description: "Payment to #{encounter.site.organization.name} for enounter-#{encounter.id}")
    payment.charge_id = charge.id
    payment.status = 'completed'
    payment.save
  end
end
