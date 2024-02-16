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
    
    it 'selecting countrys & airports limits date options to those with flights' do
      visit root_path
      select 'United Kingdom', from: 'departure_country'
      select 'London ~-~ Heathrow', from: 'departure_airport_id'
      select 'France', from: 'arrival_country'
      select 'Charles de Gaulle', from: 'arrival_airport_id'
      fill_in 'departure_date', with: '2024-02-16'
      
      max_wait_time, start_time = 200.seconds , Time.now
      date_input = find("input[name='departure_date']")
      min, max = date_input[:min], date_input[:max]
      loop do
        break if min == Date.today.to_s && max == Date.today.to_s
        sleep 0.1
        break if Time.now - start_time > max_wait_time
      end
      puts "min: #{min}, max: #{max}"
      
      expect(min).to eq((Date.today).to_s)
      expect(max).to eq((Date.today).to_s)
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
