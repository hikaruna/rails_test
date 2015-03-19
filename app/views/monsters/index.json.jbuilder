json.array!(@monsters) do |monster|
  json.extract! monster, :id, :name, :no, :evolution_from_id
  json.url monster_url(monster, format: :json)
end
