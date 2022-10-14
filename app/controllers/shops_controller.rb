class ShopsController < ApplicationController
  schema :buy do
    required(:shop_id).value(:integer)
    required(:user_id).value(:integer)
    required(:amount).value(:float)
    required(:use_bonuses).value(:bool)
  end

  def index
    shops = ShopResource.all(params)
    respond_with(shops)
  end

  def show
    shop = ShopResource.find(params)
    respond_with(shop)
  end

  def create
    shop = ShopResource.build(params)

    if shop.save
      render jsonapi: shop, status: 201
    else
      render jsonapi_errors: shop
    end
  end

  def update
    shop = ShopResource.find(params)

    if shop.update_attributes
      render jsonapi: shop
    else
      render jsonapi_errors: shop
    end
  end

  def destroy
    shop = ShopResource.find(params)

    if shop.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: shop
    end
  end

  def buy
    if safe_params && safe_params.failure?
      render json: {
        success: false,
        errors: safe_params.errors.to_h
      }
    else
      card = Card.find_by!(user_id: safe_params[:user_id], shop_id: safe_params[:shop_id])

      render json: {
        success: true,
        data: card.update_bonuses(safe_params[:amount], safe_params[:use_bonuses])
      }
    end
  end
end
