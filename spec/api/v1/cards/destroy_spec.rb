require 'rails_helper'

RSpec.describe "cards#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/cards/#{card.id}"
  end

  describe 'basic destroy' do
    let!(:card) { create(:card) }

    it 'updates the resource' do
      expect(CardResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Card.count }.by(-1)
      expect { card.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
