require 'rails_helper'

RSpec.describe "Rooms API", type: :request do

  let!(:rooms) { create_list(:room, 5) }
  let(:room_id) { rooms.first.id }

  describe 'GET /rooms' do
    before { get '/rooms' }

    it 'returns rooms' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end


  describe 'GET /rooms/:id' do
    before { get "/rooms/#{room_id}" }

    context 'when record exists' do

      it 'returns the room' do
        expect(json).not_to be_empty
        expect(json["id"]).to eq(room_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

    end

    context 'when the record does not exist' do
      let(:room_id) { 150 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Room/ )
      end
    end

  end

  describe 'POST /rooms' do
    let(:attributes) { { name: 'São Paulo' } }

    context 'when valid request' do
      before { post '/rooms', params: attributes }

      it 'creates a room' do
        expect(json['name']).to eq('São Paulo')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/rooms' }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        expect(response.body).to match(/Name can't be blank/)
      end
    end
  end

  describe 'PATCH /rooms/:id' do
    let(:attributes) { { name: 'Rio de Janeiro' } }

    context 'when room exist' do
      before {patch "/rooms/#{room_id}", params: attributes}

      it 'updates the room' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when room does not exit' do
      before {patch "/rooms/13192", params: attributes}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns error msg' do
        expect(response.body).to match(/Couldn't find Room/ )
      end
    end
  end

  describe 'DELETE /rooms/:id' do

    context 'when room exist' do
      before {delete "/rooms/#{room_id}"}

      it 'deletes the room' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when room does not exit' do
      before {delete "/rooms/13192"}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns error msg' do
        expect(response.body).to match(/Couldn't find Room/ )
      end
    end
  end
end
