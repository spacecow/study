Study::Application.routes.draw do
  root :to => 'glossaries#index'
  get 'welcome' => 'glossaries#index'

  match 'fake_login', to:'sessions#create'
  match 'auth/:provider/callback', to:'sessions#create'
  match 'auth/failure', to:redirect('/')
  match 'signout', to:'sessions#destroy'

  resources :users, :only => :show

  resources :kanjis, :only => [:show,:index,:edit,:update]
  resources :glossaries, :only => [:show,:index,:edit,:update]
  resources :sentences, :only => [:show,:index,:new,:create,:edit,:update]
  resources :projects, :only => [:new,:create,:edit,:update]

  #-- Translations
  resources :locales, :only => :index
  resources :translations, :only => [:index,:create] do
    collection do
      put 'update_multiple'
    end
  end
end
