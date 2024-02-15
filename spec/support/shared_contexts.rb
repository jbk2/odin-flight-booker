RSpec.shared_context 'common setup' do
  let!(:airport_1) { create(:airport_1) }
  let!(:airport_2) { create(:airport_2) }
  let!(:flight) { create(:flight_1, departure_airport: airport_1, arrival_airport: airport_2) }
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