# == Schema Information
#
# Table name: airports
#
#  id         :bigint           not null, primary key
#  name       :string
#  code       :string
#  country_id :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country    :string
#  city       :string
#
require 'rails_helper'

RSpec.describe Airport, type: :model do
  include_context 'common setup'

  RSpec.shared_examples 'an airport with mandatory attributes' do |attribute|
    it "is invalid without a #{attribute}" do
      airport = Airport.new(valid_attributes.merge(attribute => nil))
      expect(airport).to be_invalid
      puts airport.errors.full_messages.to_sentence
      expect(airport.errors[attribute]).to include("can't be blank")
    end
  end

  describe 'validations' do
    let(:valid_attributes) {
      { name: 'Parisian Airport', code:'0001', country_id: '01', country: 'France', city: 'Paris' }
    }

    [:name, :code, :country_id, :country, :city].each do |attribute|
      include_examples 'an airport with mandatory attributes', attribute
    end
  end

  describe 'associations' do
    it 'has many departing flights' do
      expect(airport_1.departing_flights).to include(flight)
    end

    it 'has many arriving flights' do
      expect(airport_2.arriving_flights).to include(flight)
    end
  end

  describe 'formatted_airport_name_label' do
    context 'when the airport name includes the city' do
      let(:airport_with_name_inc_city) { create(:airport_1, name: 'London Heathrow Airport') }
      it "returns the name unchanged" do
        expect(airport_with_name_inc_city.formatted_airport_name_label).to eq('London Heathrow Airport')
      end
    end

    context 'when the airport name does not include the city' do
      let(:airport_without_city_in_name) { airport_1 }
      it "returns the name prefixed with with the city and a tilde" do
        expect(airport_without_city_in_name.formatted_airport_name_label).to eq('London ~-~ Heathrow')
      end
    end
  end
    
end
