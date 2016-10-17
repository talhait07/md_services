json.(user, :id, :first_name, :last_name, :email, :god)
if user.organization_user.nil?
  json.role nil
else
  json.role do
    json.partial!('api/v1/organization_users/organization_user', organization_user: user.organization_user)
  end
end
