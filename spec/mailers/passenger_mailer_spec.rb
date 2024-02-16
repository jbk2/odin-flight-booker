require "rails_helper"

RSpec.describe PassengerMailer, type: :mailer do
  include_context 'common setup'
  
  describe 'welcome_booking_owner' do
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

  describe 'flight_reminder' do
    let(:mail) { PassengerMailer.with(booking: booking_1, passenger: passenger_2).flight_reminder }

    it 'renders the headers' do
      expect(mail.subject).to include("Flight to Charles de Gaulle on")
      expect(mail.to).to eq([passenger_2.email])
      expect(mail.from).to eq(['info@flight-booker.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match("Hi #{passenger_2.name}, we're looking forward to welcoming you aboard your flight:")
      expect(mail.body.encoded).to match(booking_1.flight.departure_airport_name)
      expect(mail.body.encoded).to match(booking_1.flight.arrival_airport_name)
    end
  end
end
