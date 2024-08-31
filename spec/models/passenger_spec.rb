# == Schema Information
#
# Table name: passengers
#
#  id                     :bigint           not null, primary key
#  email                  :string
#  encrypted_password     :string           default("")
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_passengers_on_email                 (email) UNIQUE
#  index_passengers_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'
require 'securerandom'

RSpec.describe Passenger, type: :model do
  include_context 'common setup'

  describe 'validations' do
    context 'without a name' do
      let(:no_name_passenger) { booking_1.passengers.new(email: 'p1@test.com') }
      it 'is invalid' do
        expect(no_name_passenger).to be_invalid
      end
    end
    context 'with a name' do
      it 'is valid' do
        expect(passenger_2).to be_valid
      end
    end
    context 'with a name <2 chars' do
      let(:one_char_passenger) { Passenger.new(email: 'p1@test.com', name: 'a') }
      it 'is invalid' do
        expect(one_char_passenger).to be_invalid
      end
    end
    context 'with a name >50 chars' do
      too_long_name = SecureRandom.alphanumeric(55)
      let(:loads_chars_passenger) { Passenger.new(email: 'p1@test.com', name: too_long_name) }
      it 'is invalid' do
        expect(loads_chars_passenger).to be_invalid
      end
    end
    context 'with a name 2-50 chars' do
      correct_length_name = SecureRandom.alphanumeric(25)
      let(:correct_length_name_passenger) { booking_1.passengers.build(email: 'p1234@test.com', name: correct_length_name, encrypted_password: "asdfasdff") }
      
      it 'is valid' do
        booking_1.passengers << correct_length_name_passenger
        booking_1.save
        expect(correct_length_name_passenger).to be_valid
      end
    end

    context 'without an email' do
      let(:no_email_passenger) { Passenger.new(name: 'p1') }
      it 'is invalid' do
        expect(no_email_passenger).to be_invalid
      end
    end
    context 'with an email' do
      it 'is valid' do
        expect(passenger_2).to be_valid
      end
    end
  end

  describe 'associations' do
    context 'a passenger has bookings' do
      it 'is valid' do
        expect(passenger_2.bookings).to be_truthy #i.e. for the association method to be defined
        expect(passenger_2.bookings).to include(booking_1)
      end
    end

    # this requirement is implemented in the controller logic and will be tested there
    context 'a passenger without bookings' do
      let(:no_bookings_passenger) { Passenger.new(name: 'p1', email: 'p1@test.com') }
      # it 'is invalid' do
      #   expect(no_bookings_passenger).to be_invalid
      # end
    end
  end

end
