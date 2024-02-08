class PassengerMailer < ApplicationMailer
  default from: 'info@flight-booker.com'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.passenger_mailer.welcome_booking_owner.subject
  #
  def welcome_booking_owner
    @greeting = "Hi"
    @booking = params[:booking]
    @booking_owner = params[:booking_owner]
    @url = new_passenger_session_url

    mail to: @booking_owner.email,
      subject: "Welcome to Flight Booker"
  end

end
