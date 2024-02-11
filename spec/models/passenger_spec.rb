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

end
