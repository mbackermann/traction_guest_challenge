require 'rails_helper'

RSpec.describe "Guests API", type: :request do

  let!(:guests) { create_list(:guest, 10) }
  let(:guest_id) { guests.first.id }

  describe 'GET /guests' do
    before { get '/guests' }

    it 'returns guests' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end


  describe 'GET /guests/:id' do
    before { get "/guests/#{guest_id}" }

    context 'when record exists' do

      it 'returns the guest' do
        expect(json).not_to be_empty
        expect(json["id"]).to eq(guest_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

    end

    context 'when the record does not exist' do
      let(:guest_id) { 150 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Guest/ )
      end
    end

  end

  describe 'POST /guests' do
    let(:attributes) { { first_name: 'Renato', last_name: 'Silva',
                         email: 'renatosilva@gmail.com',
                         document_id: '1234567'} }

    context 'when valid request' do
      before { post '/guests', params: attributes }

      it 'creates a Guest' do
        expect(json['first_name']).to eq('Renato')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/guests' }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        expect(response.body).to match(/First name can't be blank/)
      end
    end
  end

  describe 'PATCH /guests/:id' do
    let(:attributes) { { first_name: 'Marcelo' } }

    context 'when guest exist' do
      before {patch "/guests/#{guest_id}", params: attributes}

      it 'updates the guest' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when guest does not exit' do
      before {patch "/guests/13192", params: attributes}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns error msg' do
        expect(response.body).to match(/Couldn't find Guest/ )
      end
    end
  end

  describe 'DELETE /guests/:id' do

    context 'when guest exists' do
      before {delete "/guests/#{guest_id}"}

      it 'deletes the guest' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when guest does not exit' do
      before {delete "/guests/13192"}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns error msg' do
        expect(response.body).to match(/Couldn't find Guest/ )
      end
    end
  end
end
