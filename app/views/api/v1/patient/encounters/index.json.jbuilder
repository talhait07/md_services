json.encounters @encounters, partial: 'api/v1/encounters/encounter', as: :encounter
json.current_page @encounters.current_page
json.total_count @encounters.total_count
json.total_pages @encounters.total_pages
