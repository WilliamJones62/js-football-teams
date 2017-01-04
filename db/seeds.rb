# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Team.create([
  {name: "Aston Villa", league: "Championship"},
  {name: "Arsenal", league: "Premiership"},
  {name: "England", league: "International"}
])

Player.create([
  {name: "Jonathan Kodjia", team_id: 0},
  {name: "Gabriel Agbonlahor", team_id: 0},
  {name: "Alexis Sanchez", team_id: 1},
  {name: "Wayne Rooney", team_id: 2}
])
