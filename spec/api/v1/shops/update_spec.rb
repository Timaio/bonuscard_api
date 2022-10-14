require 'rails_helper'

RSpec.describe "shops#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/shops/#{shop.id}", payload
  end

  describe 'basic update' do
    let!(:shop) { create(:shop) }

    let(:payload) do
      {
        data: {
          id: shop.id.to_s,
          type: 'shops',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(ShopResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { shop.reload.attributes }
    end
  end
end
