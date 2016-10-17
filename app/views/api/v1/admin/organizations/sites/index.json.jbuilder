json.sites @sites, partial: 'api/v1/sites/site', as: :site
json.current_page @sites.current_page
json.total_count @sites.total_count
json.total_pages @sites.total_pages
