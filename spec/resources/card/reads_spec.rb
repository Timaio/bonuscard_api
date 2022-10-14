require 'rails_helper'

RSpec.describe CardResource, type: :resource do
  describe 'serialization' do
    let!(:card) { create(:card) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(card.id)
      expect(data.jsonapi_type).to eq('cards')
    end
  end

  describe 'filtering' do
    let!(:card1) { create(:card) }
    let!(:card2) { create(:card) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: card2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([card2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:card1) { create(:card) }
      let!(:card2) { create(:card) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            card1.id,
            card2.id
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
            card2.id,
            card1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
