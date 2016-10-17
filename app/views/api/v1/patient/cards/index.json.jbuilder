json.array! @cards do |card|
  json.partial! 'api/v1/patient/cards/card', card: card
end
