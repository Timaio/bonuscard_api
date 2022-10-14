class CardsController < ApplicationController
  def index
    cards = CardResource.all(params)
    respond_with(cards)
  end

  def show
    card = CardResource.find(params)
    respond_with(card)
  end

  def create
    card = CardResource.build(params)

    if card.save
      render jsonapi: card, status: 201
    else
      render jsonapi_errors: card
    end
  end

  def update
    card = CardResource.find(params)

    if card.update_attributes
      render jsonapi: card
    else
      render jsonapi_errors: card
    end
  end

  def destroy
    card = CardResource.find(params)

    if card.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: card
    end
  end
end
