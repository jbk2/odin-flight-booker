require 'rails_helper'

RSpec.describe "Flights", type: :system do
  include_context 'common setup'
  before do
    driven_by(:selenium_chrome_headless)
  end

  context 'in flights#index/root page'  do
    it 'selecting departure country filters corresponding departure airports' do
      visit root_path
      select 'United Kingdom', from: 'departure_country'
      expect(page).to have_select('departure_airport_id', with_options: ['London ~-~ Heathrow'], disabled: false)
    end
    
    it 'selecting arrival country filters corresponding departure airports' do
      visit root_path
      select 'France', from: 'arrival_country'
      expect(page).to have_select('arrival_airport_id', with_options: ['Charles de Gaulle'], disabled: false)
    end

  end

  # - navigate to the flights index / root page
  #   - select departure country and check that airports.where country
  #   - select arrival country and check that airports.where country
  #   - ensure that the dates with flights are selectable
  #   - click search button and ensure that flight results appear
  #   - select a flight and ensure that the booking page appears
  #   - ensure that you can add and remove passengers
  #   - select book flight and ensure that password modal appears
  #   - complete password and ensure that it goes to booking show
end
