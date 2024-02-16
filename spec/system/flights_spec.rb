require 'rails_helper'

RSpec.describe "Flights", type: :system do
  include_context 'common setup'
  before { driven_by(:selenium_chrome_headless) }

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

    it 'on submission of completed search form returns flight results' do
      complete_search_form
      click_button 'Search Flights'
      expect(page).to have_content('Flight results')
    end

    it 'can select a flight and reach the booking form' do
      complete_search_form
      click_button 'Search Flights'
      click_button 'Book Flight'
      expect(page).to have_content('Booking form')
    end
    
    it 'can select a flight, complete password, and complete a booking' do
      complete_search_form
      click_button 'Search Flights'
      click_button 'Book Flight'
      fill_in 'passengers_0_name', with: 'Joe Bloggs'
      fill_in 'passengers_0_email', with: 'Joe@test.com'
      click_button 'Create Booking'
      password_input = find('input[name="passenger[password]"]', visible: :all)
      password_confirmation_input = find('input[name="passenger[password_confirmation]"]', visible: :all)
      password_input.set('Password12!')
      password_confirmation_input.set('Password12!')
      find('input[type="submit"][value="Set Password"]', visible: :all).click
      expect(page).to have_content('Your bookings')
      save_screenshot('booking_show.png')
    end
  end
  #   - ensure that you can add and remove passengers
  #   - ensure that front end validation works for name and email fields
end
