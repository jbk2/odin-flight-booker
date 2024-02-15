require 'rails_helper'

RSpec.describe "Bookings", type: :request do
  describe "GET /index" do
    include_context 'common setup'
   
    context 'when multiple bookings are made' do
      it 'responds successfully with HTTP200' do
        sign_in booking_owner
        get bookings_path
        expect(response).to have_http_status(200)
        expect(assigns(:owned_bookings).to_a).to eq([booking_1, booking_2])
      end
    end

  end
end
