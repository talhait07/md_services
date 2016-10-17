json.array! @payments do |payment|
  json.partial! 'api/v1/patient/encounters/payments/payment', payment: payment
end
