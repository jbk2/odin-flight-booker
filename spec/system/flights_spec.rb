require 'rails_helper'

RSpec.describe "Flights", type: :system do
  before do
    driven_by(:rack_test)
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
