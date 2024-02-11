# == Schema Information
#
# Table name: passengers
#
#  id                     :bigint           not null, primary key
#  name                   :string
#  email                  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default("")
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#
require 'rails_helper'
require 'securerandom'

RSpec.describe Passenger, type: :model do
  include_context 'common setup'

  describe 'validations' do
    context 'without a name' do
      let(:no_name_passenger) { Passenger.new(email: 'p1@test.com') }
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
      let(:loads_chars_passenger) { Passenger.new(email: 'p1@test.com', name: correct_length_name) }
      it 'is valid' do
        expect(loads_chars_passenger).to be_valid
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
    
  end

end
