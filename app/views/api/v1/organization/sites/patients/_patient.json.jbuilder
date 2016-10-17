json.(patient, :id)
json.user do
  json.partial! 'api/v1/users/user', user: patient.user
end
json.profile do
  json.partial! 'api/v1/profiles/profile', profile: patient.user.profile
end
