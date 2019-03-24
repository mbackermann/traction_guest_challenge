require 'rails_helper'

RSpec.describe "Tracks API", type: :request do
  let!(:rooms) { create_list(:room, 2) }
  let!(:guest) { create(:guest) }
  let(:guest_id) { guest.id }
  let!(:tracks1) { create_list(:track, 10, room_id: rooms.first.id, guest_id: guest_id) }
  let!(:tracks2) { create_list(:track, 10, room_id: rooms.last.id, guest_id: guest_id) }
  let(:track_id) { tracks1.last.id }

  describe 'GET /tracks' do
    before { get '/tracks' }

    it 'returns tracks' do
      expect(json).not_to be_empty
      expect(json.size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET Room Tracks /rooms/:id/tracks' do
    before { get "/rooms/#{rooms.first.id}/tracks" }

    context 'when room exists' do

      it 'returns tracks' do
        expect(json).not_to be_empty
        expect(json.size).to be(10)
      end

    end

    context 'when room does not exist' do
      before { get "/rooms/9123971/tracks" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Room/)
      end

    end
  end

  describe 'GET Guest Tracks /guests/:id/tracks' do
    before { get "/guests/#{guest_id}/tracks" }

    context 'when guest exists' do

      it 'returns tracks' do
        expect(json).not_to be_empty
        expect(json.size).to be(20)
      end

    end

    context 'when guest does not exist' do
      before { get "/guests/9123971/tracks" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Guest/)
      end

    end
  end

  describe 'POST /rooms/:id/tracks' do

    context 'when attributes are correct' do
      let(:attributes) { {guest_id: guest_id, status: "Entered" } }
      before {post "/rooms/#{rooms.first.id}/tracks", params: attributes}

      it 'creates a track' do
        expect(json['guest_id']).to be(guest_id)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

    end

    context "when attributes are wrong" do
      let(:attributes) { {guest_id: 9123191, status: "Entered" } }
      before {post "/rooms/#{rooms.first.id}/tracks", params: attributes}

      it 'returns code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns error message' do
        expect(response.body).to match(/Couldn't find Guest/ )
      end
    end
  end

  describe 'GET /tracks/:id' do
    before { get "/tracks/#{track_id}" }

    context 'when record exists' do

      it 'returns the track' do
        expect(json).not_to be_empty
        expect(json["id"]).to eq(track_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

    end

    context 'when the record does not exist' do
      let(:track_id) { 150 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Track/ )
      end
    end

  end

  describe 'DELETE /tracks/:id' do

    context 'when track exists' do
      before {delete "/tracks/#{track_id}"}

      it 'deletes the track' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when track does not exit' do
      before {delete "/tracks/13192"}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns error msg' do
        expect(response.body).to match(/Couldn't find Track/ )
      end
    end
  end

end
