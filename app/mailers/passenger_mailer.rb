class PassengerMailer < ApplicationMailer
  default from: 'info@flight-booker.com'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #   en.passenger_mailer.welcome_booking_owner.subject

  def welcome_booking_owner
    @greeting = "Hi"
    @booking = params[:booking]
    @booking_owner = params[:booking_owner]
    @passengers = @booking.passengers
    @url = new_passenger_session_url

    mail to: @booking_owner.email,
      subject: "Welcome to Flight Booker"
  end

  def flight_reminder
    @booking = params[:booking]
    @passenger = params[:passenger]
    @flight = @booking.flight
    @url = booking_url(@booking)
    
    mail to: @passenger.email,
      subject: "Flight to #{@flight.arrival_airport.name} on #{@flight.departure_time.strftime('%a %dth %b %Y, %R%P')}."
  end

end