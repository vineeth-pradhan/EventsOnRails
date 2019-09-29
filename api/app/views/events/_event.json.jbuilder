json.extract! event, :id, :title, :starttime, :endtime, :description, :allday, :created_at, :updated_at
json.url event_url(event, format: :json)
