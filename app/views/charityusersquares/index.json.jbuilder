json.array!(@charityusersquares) do |charityusersquare|
  json.extract! charityusersquare, :id
  json.url charityusersquare_url(charityusersquare, format: :json)
end
