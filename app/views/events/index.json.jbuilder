json.array!(@events) do |event|
  json.extract! event, :id, :name, :description, :start_time, :duration, :venue
  json.url event_url(event, format: :json)
end
