Rails.application.routes.draw do
  scope path: ApplicationResource.endpoint_namespace, defaults: { format: :jsonapi } do
    resources :cards, only: [:show, :index]
    resources :users, only: [:create, :show, :update, :index]
    resources :shops, only: [:create, :show, :update, :index] do
      post "buy"
    end

    mount VandalUi::Engine, at: '/vandal'
  end
end
