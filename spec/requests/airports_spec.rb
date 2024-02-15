require 'rails_helper'

RSpec.describe "Airports", type: :request do
  
  describe "GET /index" do
    include_context 'common setup'

    context 'when no sort params are provided' do
      it 'responds successfully with HTTP200 & default sorts as ASC' do
        get airports_path
        expect(response).to have_http_status(200)
        expect(assigns(:airports).to_a).to eq([airport_2, airport_1, airport_3])
      end
    end

    context 'when desc sort param is provided' do
      it 'responds successfully with HTTP 200 & sorts in DSC' do
        get airports_path, params: { direction: 'desc' }
        expect(response).to have_http_status(200)
        expect(assigns(:airports).to_a).to eq([airport_3, airport_1, airport_2])
      end
    end
    
    context 'when direction desc and column city params are provided' do
      it 'responds successfully with HTTP 200 sorted in DSC by city' do
        get airports_path, params: { direction: 'desc', column: 'city' }
        expect(response).to have_http_status(200)
        expect(assigns(:airports).to_a).to eq([airport_2, airport_3, airport_1])
      end
    end

    context 'when invalid sort params are provided' do
      it 'ignores invalid column and defaults to country asc' do
        get airports_path, params: { column: 'invalid_column', direction: 'asc' }
        expect(assigns(:airports).to_a).to eq([airport_2, airport_1, airport_3])
      end

      it 'ignores invalid direction and defaults to asc for valid column' do
        get airports_path, params: { column: 'name', direction: 'invalid_direction' }
        expect(assigns(:airports).to_a).to eq([airport_2, airport_1, airport_3])
      end
    end

  end
end
