# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Monster.create(
  name: 'フシギダネ',
  no: 1,
)
Monster.create(
  name: 'フシギソウ',
  no: 2,
  evolution_from_id: 1,
)
Monster.create(
  name: 'フシギバナ',
  no: 3,
  evolution_from_id: 2,
)
