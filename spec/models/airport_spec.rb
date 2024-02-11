require 'rails_helper'

RSpec.describe Airport, type: :model do

  RSpec.shared_examples 'an airport with mandatory attributes' do |attribute|
    it "is invalid without a #{attribute}" do
      airport = Airport.new(valid_attributes.except(attribute))
      expect(airport).to be_invalid
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
    # it { should have_many(:departing_flights).class_name('Flight').with_foreign_key('departure_airport_id') } # shoulda-matchers implementation
    # it { should have_many(:arriving_flights).class_name('Flight').with_foreign_key('arrival_airport_id') } # shoulda-matchers implementation
    let(:airport_1) { Airport.create(name: 'Parisian Airport', code:'0001', country_id: '01', country: 'France', city: 'Paris') }
    let(:airport_2) { Airport.create(name: 'Spanish Airport', code:'0002', country_id: '02', country: 'Spain', city: 'Madrid') }
    let(:flight) { Flight.create(departure_airport: airport_1, arrival_airport: airport_2, departure_time: Time.now + 1.hour , arrival_time: Time.now + 3.hours) }

    it 'has many arriving flights' do
      expect(airport_2.arriving_flights).to include(flight)
    end
    
    it 'has many departing flights' do
      expect(airport_1.departing_flights).to include(flight)
    end
  end

  describe 'formatted_airport_name_label' do
    context 'when the airport name includes the city' do
      let(:airport_with_name_inc_city) { Airport.create(name: 'Madrid airport', code:'0002', country_id: '02', country: 'Spain', city: 'Madrid') }
      it "returns the name unchanged" do
        expect(airport_with_name_inc_city.formatted_airport_name_label).to eq('Madrid airport')
      end
    end

    context 'when the airport name does not include the city' do
      let(:airport_without_city_in_name) { Airport.create(name: 'Madrillian airport', code:'0002', country_id: '02', country: 'Spain', city: 'Madrid') }
      it "returns the name prefixed with with the city and a tilde" do
        expect(airport_without_city_in_name.formatted_airport_name_label).to eq('Madrid ~-~ Madrillian airport')
      end
    end
  end
    
end
