require 'csv'
require 'byebug'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ALL_AIRPORTS = Rails.root.join('db', 'airports.csv')
TOP100_CITIES = YAML.load_file(Rails.root.join('db', 'top100_european_cities.yml'))

def select_european_airports
  all_airports = CSV.parse(File.read(ALL_AIRPORTS), headers: true)
  european_airports = all_airports.select do |airport|
    airport["time_zone_id"] =~ /^Europe/ &&
      TOP100_CITIES['name'].any? { |city| airport["name"].include?(city) }
  end.map do |airport|
    {
      airport_code: airport["code"],
      airport_name: airport["name"],
      country_id: airport["country_id"]
    }
  end
  european_airports.sort_by { |airport| airport[:airport_name] }
end

def seed_airports
 select_european_airports.each do |airport|
    Airport.create(name: airport[:airport_name],
      code: airport[:airport_code],
      country_id: airport[:country_id]
    )
  end
end

seed_airports
