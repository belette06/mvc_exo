# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions',
                                     registrations: "admins/registrations",
                                     confirmations: "admins/confirmations" }

  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: "users/registrations",
                                    confirmations: "users/confirmations" }

  root to: 'home#landing_page'

  namespace 'administration' do
    get '/', to: 'items#index'

    resources :items
    resources :profiles do
      member do
        get '/send_email', to: "profiles#send_email", as: :send_email
      end
    end
  end
end
