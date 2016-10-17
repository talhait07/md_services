json.organizations @organizations, partial: 'api/v1/organizations/organization', as: :organization
json.current_page @organizations.current_page
json.total_count @organizations.total_count
json.total_pages @organizations.total_pages
