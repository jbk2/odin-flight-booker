# == Schema Information
#
# Table name: flights
#
#  id                   :bigint           not null, primary key
#  departure_airport_id :bigint           not null
#  arrival_airport_id   :bigint           not null
#  departure_time       :datetime
#  arrival_time         :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  flight_duration_secs :integer
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
