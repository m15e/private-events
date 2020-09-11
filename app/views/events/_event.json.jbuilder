json.extract! event, :id, :time, :location, :title, :description, :created_at, :updated_at
json.url event_url(event, format: :json)
