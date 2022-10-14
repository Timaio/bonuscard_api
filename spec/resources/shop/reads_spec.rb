require 'rails_helper'

RSpec.describe ShopResource, type: :resource do
  describe 'serialization' do
    let!(:shop) { create(:shop) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(shop.id)
      expect(data.jsonapi_type).to eq('shops')
    end
  end

  describe 'filtering' do
    let!(:shop1) { create(:shop) }
    let!(:shop2) { create(:shop) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: shop2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([shop2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:shop1) { create(:shop) }
      let!(:shop2) { create(:shop) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            shop1.id,
            shop2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            shop2.id,
            shop1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
