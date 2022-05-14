json.extract! profile, :id, :user_id, :first_name, :last_name, :public, :dob, :description, :messenger_url, :created_at, :updated_at
json.url profile_url(profile, format: :json)
