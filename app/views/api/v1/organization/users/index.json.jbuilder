json.users @users, partial: 'api/v1/users/user', as: :user
json.current_page @users.current_page
json.total_count @users.total_count
json.total_pages @users.total_pages
