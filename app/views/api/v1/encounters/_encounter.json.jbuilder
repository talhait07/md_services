json.(encounter, :id, :status, :first_name, :last_name, :birth_date, :phone_number)
json.balance humanized_money encounter.balance
json.remaining_balance humanized_money encounter.remaining_balance
json.site do
  json.partial! 'api/v1/sites/site', site: encounter.site
end
json.created_at encounter.created_at
