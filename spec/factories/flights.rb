# == Schema Information
#
# Table name: flights
#
#  id                   :bigint           not null, primary key
#  arrival_time         :datetime
#  departure_time       :datetime
#  flight_duration_secs :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  arrival_airport_id   :bigint           not null
#  departure_airport_id :bigint           not null
#
# Indexes
#
#  index_flights_on_arrival_airport_id    (arrival_airport_id)
#  index_flights_on_departure_airport_id  (departure_airport_id)
#
# Foreign Keys
#
#  fk_rails_...  (arrival_airport_id => airports.id)
#  fk_rails_...  (departure_airport_id => airports.id)
#
FactoryBot.define do
  factory :flight_1, class: 'Flight' do
    departure_airport { create(:airport_1) }
    arrival_airport   { create(:airport_2) }
    departure_time    { 1.hour.from_now }
    arrival_time      { 3.hours.from_now }
  end
  
  factory :flight_2, class: 'Flight' do
    departure_airport { create(:airport_2) }
    arrival_airport   { create(:airport_1) }
    departure_time    { 7.days.from_now }
    arrival_time      { 7.days.from_now }
  end
end
