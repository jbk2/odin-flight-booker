require 'rails_helper'

RSpec.describe "Authentication", type: :system do
  before do
    driven_by(:rack_test)
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

  # - check that a passenger can sign up outside of the booking flow
end
