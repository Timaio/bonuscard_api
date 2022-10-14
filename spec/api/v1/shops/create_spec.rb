require 'rails_helper'

RSpec.describe "shops#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/shops", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:shop)
    end
    let(:payload) do
      {
        data: {
          type: 'shops',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(ShopResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Shop.count }.by(1)
    end
  end
end
