Rails.application.routes.draw do
  resources :customers
  resources :orders do
    member do
      get 'download'
      get 'send_mail'
    end
  end

  root 'orders#index'
end
