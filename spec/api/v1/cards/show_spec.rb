require 'rails_helper'

RSpec.describe "cards#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/cards/#{card.id}", params: params
  end

  describe 'basic fetch' do
    let!(:card) { create(:card) }

    it 'works' do
      expect(CardResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('cards')
      expect(d.id).to eq(card.id)
    end
  end
end
