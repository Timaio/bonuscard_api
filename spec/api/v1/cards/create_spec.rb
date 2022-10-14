require 'rails_helper'

RSpec.describe "cards#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/cards", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:card)
    end
    let(:payload) do
      {
        data: {
          type: 'cards',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(CardResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Card.count }.by(1)
    end
  end
end
