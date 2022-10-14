require 'rails_helper'

RSpec.describe "shops#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/shops/#{shop.id}"
  end

  describe 'basic destroy' do
    let!(:shop) { create(:shop) }

    it 'updates the resource' do
      expect(ShopResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Shop.count }.by(-1)
      expect { shop.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
