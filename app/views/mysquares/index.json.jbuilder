json.array!(@mysquares) do |mysquare|
  json.extract! mysquare, :id, :name, :square_raiser_id, :info, :lat, :long
  json.url mysquare_url(mysquare, format: :json)
end
