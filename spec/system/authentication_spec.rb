require 'rails_helper'

RSpec.describe "Authentication", type: :system do
  include_context 'common setup'
  before do
    driven_by(:selenium_chrome_headless)
    # Capybara.current_driver = :selenium_chrome
  end

  it 'allows a new passenger to sign up' do
    visit new_passenger_registration_path
    fill_in 'Name', with: 'Joe Bloggs'
    fill_in 'Email', with: 'test1@test.com'
    fill_in 'Password', with: 'Password12!'
    fill_in 'Password confirmation', with: 'Password12!'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  it 'allows a passenger to sign in and out' do
    visit new_passenger_session_path
    fill_in 'Email', with: passenger_2.email
    fill_in 'Password', with: passenger_2.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
    click_on "Logout"
    expect(page).to have_text("Signed out successfully.")
  end

end
