require 'rails_helper'

RSpec.describe "cards#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/cards/#{card.id}", payload
  end

  describe 'basic update' do
    let!(:card) { create(:card) }

    let(:payload) do
      {
        data: {
          id: card.id.to_s,
          type: 'cards',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(CardResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { card.reload.attributes }
    end
  end
end
