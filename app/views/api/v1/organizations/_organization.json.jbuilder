json.(organization, :id, :name, :npi_number, :positions, :address_1, :address_2, :city, :state, :postal_code, :phone_number, :url)
json.sites_count organization.sites.size
json.organization_users_count organization.organization_users.size
