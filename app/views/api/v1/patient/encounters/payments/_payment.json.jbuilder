json.(payment, :id, :charge_id, :status)
json.amount humanized_money payment.amount
json.created_at payment.created_at
