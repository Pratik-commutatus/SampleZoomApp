json.extract! meeting, :id, :username, :user_email, :meeting_id, :meeting_password, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)
