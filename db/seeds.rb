require 'csv'
require 'byebug'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

top100_cities = Rails.root.join('db', 'top100_european_cities.yml')
TOP100_CITIES = YAML.load_file(top100_cities)

def set_european_airports
  airport_data = CSV.parse(File.read(Rails.root.join('db', 'airports.csv')), headers: true)
  european_airports = []
  airport_data.each do |airport|
    if airport["time_zone_id"] =~ /^Europe/ && TOP100_CITIES['top100_european_cities'].any? { |city| airport["name"].include?(city) }
      european_airports << { airport_code: airport["code"],
        airport_name: airport["name"],
        country_id: airport["country_id"]
      }
    end 
  end
  european_airports.sort_by { |airport| airport[:airport_name] }
end

def seed_airports
 set_european_airports.each do |airport|
    Airport.create(name: airport[:airport_name],
      code: airport[:airport_code],
      country_id: airport[:country_id]
    )
  end
end

seed_airports
