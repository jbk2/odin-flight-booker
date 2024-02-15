FactoryBot.define do
  factory :flight_1, class: 'Flight' do
    departure_airport { create(:airport_1) }
    arrival_airport   { create(:airport_2) }
    departure_time    { 1.hour.from_now }
    arrival_time      { 3.hours.from_now }
  end
end
