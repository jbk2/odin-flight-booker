RSpec.shared_context 'common setup' do
  let!(:airport_1) { Airport.create(name: 'Parisian Airport', code:'0001', country_id: '01', country: 'France', city: 'Paris') }
  let!(:airport_2) { Airport.create(name: 'Spanish Airport', code:'0002', country_id: '02', country: 'Spain', city: 'Madrid') }
  let!(:flight) { Flight.create(departure_airport: airport_1, arrival_airport: airport_2, departure_time: 1.hour.from_now , arrival_time: 3.hours.from_now) }
  let!(:booking_owner) { Passenger.create(name: "joe", email: "joe@test.com", encrypted_password: "Password12!") }
  let!(:passenger_2) { Passenger.create(name: "jim", email: "jim@test.com", encrypted_password: "Password12!") }
  let(:booking) {
    booking = flight.bookings.build(booking_owner: booking_owner)
    booking.passengers << booking_owner
    booking.passengers << passenger_2

    booking.passengers.each do |passenger|
      unless passenger.valid?
        puts "Passenger validation errors: #{passenger.errors.full_messages}"
      end
    end
    
    booking.save!
    booking
  }
end