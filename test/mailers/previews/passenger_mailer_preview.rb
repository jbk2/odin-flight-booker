# Preview all emails at http://localhost:3000/rails/mailers/passenger_mailer
class PassengerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/passenger_mailer/welcome_booking_owner

  def welcome_booking_owner
    booking = Booking.first
    booking_owner = booking.booking_owner
    PassengerMailer.with(booking: booking, booking_owner: booking_owner).welcome_booking_owner
  end



end
