require 'rails_helper'

RSpec.describe "shops#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/shops", params: params
  end

  describe 'basic fetch' do
    let!(:shop1) { create(:shop) }
    let!(:shop2) { create(:shop) }

    it 'works' do
      expect(ShopResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['shops'])
      expect(d.map(&:id)).to match_array([shop1.id, shop2.id])
    end
  end
end
