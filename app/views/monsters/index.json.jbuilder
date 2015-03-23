json.array!(@monsters) do |monster|
  json.extract! monster, :id, :name, :no, :evolution_from_id, :kind, :type1, :type2
  json.url monster_url(monster, format: :json)
  json.evolution_from_name monster.evolution_from.try(:name)
end
