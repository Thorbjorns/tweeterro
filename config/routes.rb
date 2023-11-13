Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  resources :groups do
    member do
      post 'join'
      delete 'leave'
    end
    get 'page/:page', action: :index, on: :collection
  end

  resources :tweets do
    member do
      delete 'delete'
      get 'new_reply', as: 'new_reply_tweet'
      post 'reply'
    end
  end

  resources :replies, only: [:new, :create]
end
