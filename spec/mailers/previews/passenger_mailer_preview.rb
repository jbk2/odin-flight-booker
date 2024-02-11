# Preview all emails at http://localhost:3000/rails/mailers/passenger_mailer
class PassengerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/passenger_mailer/welcome_booking_owner
  # Create a booking on front end to run this preview
  def welcome_booking_owner
    booking = Booking.first
    booking_owner = booking.booking_owner
    passengers = booking.passengers
    
    PassengerMailer.with(booking: booking, booking_owner: booking_owner,
      passengers: passengers).welcome_booking_owner
  end


  def flight_reminder
    booking = Booking.first
    passenger = booking.passengers.first
    flight = booking.flight
    PassengerMailer.with(booking: booking, passenger: passenger).flight_reminder
  end


end
