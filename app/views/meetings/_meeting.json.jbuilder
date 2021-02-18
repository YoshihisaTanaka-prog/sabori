json.extract! meeting, :id, :eventId, :fiscalYear, :eventNumber, :field, :title, :keyword, :organization, :stard, :end, :place, :url, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)
