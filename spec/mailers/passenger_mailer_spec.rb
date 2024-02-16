require "rails_helper"

RSpec.describe PassengerMailer, type: :mailer do
  
  describe 'welcome_booking_owner' do
    include_context 'common setup'
    let(:mail) { PassengerMailer.with(booking: booking_1, booking_owner: booking_owner).welcome_booking_owner }

    it 'renders the headers' do
      expect(mail.subject).to eq("Welcome to Flight Booker")
      expect(mail.to).to eq([booking_owner.email])
      expect(mail.from).to eq(["info@flight-booker.com"])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match("Hi")
      expect(mail.body.encoded).to match("Thanks for signing up")
      expect(mail.body.encoded).to match(booking_1.flight.departure_airport.name)
      expect(mail.body.encoded).to match(booking_1.flight.arrival_airport.name)
    end
  end
end
