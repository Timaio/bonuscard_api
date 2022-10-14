require 'rails_helper'

RSpec.describe CardResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'cards',
          attributes: attributes_for(:card)
        }
      }
    end

    let(:instance) do
      CardResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Card.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:card) { create(:card) }

    let(:payload) do
      {
        data: {
          id: card.id.to_s,
          type: 'cards',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      CardResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { card.reload.updated_at }
      # .and change { card.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:card) { create(:card) }

    let(:instance) do
      CardResource.find(id: card.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Card.count }.by(-1)
    end
  end
end
