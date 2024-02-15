RSpec.shared_context 'common setup' do
  let!(:airport_1) { create(:airport_1) }
  let!(:airport_2) { create(:airport_2) }
  let!(:flight) { create(:flight_1, departure_airport: airport_1, arrival_airport: airport_2) }
  let!(:booking_owner) { create(:passenger_1) }
  let!(:passenger_2) { create(:passenger_2) }
  let!(:booking) {
    create(:booking, flight: flight, booking_owner: booking_owner, passengers: [booking_owner, passenger_2])
  }
end