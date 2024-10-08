require './lib/tasks/airport_seeder'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def seed_airports(airports)
  puts "Seeding #{airports.count} airports"
  airports.each do |airport|
    Airport.create(
      code: airport[:airport_code],
      city: airport[:city],
      country: airport[:country],
      country_id: airport[:country_id],
      name: airport[:airport_name]
    )
  end
  puts "Seeded #{Airport.count} airports"
end

def seed_flights
  puts "Seeding 5000 flights"
  5000.times do
    ids = (1..Airport.count).to_a.shuffle.take(2)
    departure_time = DateTime.now + rand(7..28).days
    Flight.create(
      departure_airport_id: ids[0],
      arrival_airport_id:ids[1],
      departure_time: departure_time,
      arrival_time: departure_time + rand(7200..28800).seconds
    )
  end
  puts "Seeded #{Flight.count} flights"
end

seed_airports(AirportSeeder.collate_european_airports)
seed_flights