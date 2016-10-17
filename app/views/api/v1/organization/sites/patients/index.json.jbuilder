json.patients @patients, partial: 'patient', as: :patient
json.current_page @patients.current_page
json.total_count @patients.total_count
json.total_pages @patients.total_pages
