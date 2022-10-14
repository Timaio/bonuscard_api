require 'rails_helper'

RSpec.describe ShopResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'shops',
          attributes: attributes_for(:shop)
        }
      }
    end

    let(:instance) do
      ShopResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Shop.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:shop) { create(:shop) }

    let(:payload) do
      {
        data: {
          id: shop.id.to_s,
          type: 'shops',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      ShopResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { shop.reload.updated_at }
      # .and change { shop.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:shop) { create(:shop) }

    let(:instance) do
      ShopResource.find(id: shop.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Shop.count }.by(-1)
    end
  end
end
