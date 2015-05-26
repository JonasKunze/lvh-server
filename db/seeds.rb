# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


if RatingMark.count < 4
  rating_marks = RatingMark.create!([
    {title: "Unbedenklich" },
    {title: "Auffällig", explanation: "Stichproben" },
    {title: "Potentielle Gefahr", explanation: "Konstant beobachten" },
    {title: "Terrorgefahr", explanation: "Als Gefahr einstufen" }
  ])
end