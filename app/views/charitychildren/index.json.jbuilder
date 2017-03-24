json.array!(@charitychildren) do |charitychild|
  json.extract! charitychild, :id, :name, :email, :address, :active, :user_id
  json.url charitychild_url(charitychild, format: :json)
end
