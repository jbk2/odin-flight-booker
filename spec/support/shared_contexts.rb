RSpec.shared_context 'common setup' do
  let!(:airport_1) { create(:airport_1) }
  let!(:airport_2) { create(:airport_2) }
  let!(:airport_3) { create(:airport_3) }
  let!(:flight) { create(:flight_1, departure_airport: airport_1, arrival_airport: airport_2) }
  let!(:booking_owner) { create(:passenger_1) }
  let!(:passenger_2) { create(:passenger_2) }
  let!(:booking_1) {
    create(:booking_1, flight: flight, booking_owner: booking_owner, passengers: [booking_owner, passenger_2])
  }
  let!(:booking_2) {
    create(:booking_2, flight: flight, booking_owner: booking_owner, passengers: [booking_owner, passenger_2])
  }
end

def complete_search_form
  visit root_path
  select 'United Kingdom', from: 'departure_country'
  select 'London ~-~ Heathrow', from: 'departure_airport_id'
  select 'France', from: 'arrival_country'
  select 'Charles de Gaulle', from: 'arrival_airport_id'
  fill_in 'departure_date', with: Date.today.strftime("%Y-%m-%d")
end