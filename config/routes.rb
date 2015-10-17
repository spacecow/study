Study::Application.routes.draw do
  root :to => 'glossaries#index'
  get 'welcome' => 'glossaries#index'

  match 'fake_login', to:'sessions#create'
  match 'auth/:provider/callback', to:'sessions#create'
  match 'auth/failure', to:redirect('/')
  get 'signin' => 'sessions#new'
  match 'signout', to:'sessions#destroy'

  resources :sessions, only:[:new,:create,:destroy]

  resources :users, :only => :show

  resources :kanjis, :only => [:show,:index,:edit,:update]
  resources :meanings, only: :show  
  resources :similarities, only: :destroy

  resources :glossaries, :only => [:show,:index,:new,:create,:edit,:update]
  resources :sentences, :only => [:show,:index,:new,:create,:edit,:update]
  resources :lookups, :only => [:edit,:update]
  resources :projects, :only => [:new,:create,:edit,:update]

  resources :quizzes, :only => [:show,:new,:create]
  resources :answers, :only => [:new,:create]

  #-- Relations
  resources :synonym_glossaries, only: :destroy
  resources :similar_glossaries, only: :destroy
  resources :antonym_glossaries, only: :destroy

  #-- Translations
  resources :locales, :only => :index
  resources :translations, :only => [:index,:create] do
    collection do
      put 'update_multiple'
    end
  end
end
