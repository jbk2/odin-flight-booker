require 'rails_helper'

RSpec.describe "Flights", type: :request do
  describe "GET /index" do
    it 'renders the index template successfully' do
      get flights_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
      expect(response.body).to include("Search Flights")
    end
  end

  describe "GET #update_departure_airports" do
    it "renders the correct Turbo Stream template" do
      get update_departure_airports_flights_path, params: { departure_country: 'Country Name' }, headers: { accept: 'text/vnd.turbo-stream.html' }
      expect(response).to have_http_status(:ok)
      expect(response.media_type).to include('text/vnd.turbo-stream.html')
      expect(response).to render_template('update_departure_airports')
    end
  end
  
  describe "GET #update_arrival_airports" do
    it "renders the correct Turbo Stream template" do
      get update_arrival_airports_flights_path, params: { arrival_country: 'Country Name' }, headers: { accept: 'text/vnd.turbo-stream.html' }
      expect(response).to have_http_status(:ok)
      expect(response.media_type).to include('text/vnd.turbo-stream.html')
      expect(response).to render_template('update_arrival_airports')
    end
  end
  
  describe "GET #update_departure_dates" do
    it "renders the correct Turbo Stream template" do
      get update_departure_dates_flights_path, params: { departure_airport_id: '1', arrival_airport_id: '2' }, headers: { accept: 'text/vnd.turbo-stream.html' }
      expect(response).to have_http_status(:ok)
      expect(response.media_type).to include('text/vnd.turbo-stream.html')
      expect(response).to render_template('update_departure_dates')
    end
  end
end
