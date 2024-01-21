require 'csv'

class AirportSeeder
  ALL_AIRPORTS = Rails.root.join('db', 'data', 'airports.csv')
  TOP50_EU_CITIES = YAML.load_file(Rails.root.join('db', 'data', 'top50_european_cities.yml'))
  COUNTRY_CODES = YAML.load_file(Rails.root.join('db', 'data', 'country_codes.yml'))

  def self.collate_european_airports
    all_airports = CSV.parse(File.read(ALL_AIRPORTS), headers: true)

    european_airports = all_airports.select do |airport|
      airport["time_zone_id"] =~ /^Europe/ &&
        TOP50_EU_CITIES['name'].any? { |city| airport["name"].include?(city) }
    end.map do |airport|
      country = COUNTRY_CODES.find { |country| country['Code'].downcase == airport["country_id"].downcase }
      {
        airport_code: airport["code"],
        airport_name: airport["name"],
        country_id: airport["country_id"],
        city: airport["city"] ? airport["city"] : 'unknown',
        country: country ? country['Name'] : nil
      }
    end
    european_airports.sort_by { |airport| airport[:airport_name] }
  end

end