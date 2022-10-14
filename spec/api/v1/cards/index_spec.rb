require 'rails_helper'

RSpec.describe "cards#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/cards", params: params
  end

  describe 'basic fetch' do
    let!(:card1) { create(:card) }
    let!(:card2) { create(:card) }

    it 'works' do
      expect(CardResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['cards'])
      expect(d.map(&:id)).to match_array([card1.id, card2.id])
    end
  end
end
