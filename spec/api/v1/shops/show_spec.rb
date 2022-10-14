require 'rails_helper'

RSpec.describe "shops#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/shops/#{shop.id}", params: params
  end

  describe 'basic fetch' do
    let!(:shop) { create(:shop) }

    it 'works' do
      expect(ShopResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('shops')
      expect(d.id).to eq(shop.id)
    end
  end
end
