Study::Application.routes.draw do
  root :to => 'glossaries#index'
  get 'welcome' => 'glossaries#index'

  match 'auth/:provider/callback', to:'sessions#create'
  match 'auth/failure', to:redirect('/')
  match 'signout', to:'sessions#destroy'

  resources :users, :only => :show

  resources :kanjis, :only => :show
  resources :glossaries, :only => [:show,:index,:edit,:update]
  resources :sentences, :only => [:show,:index,:new,:create,:edit,:update]
  resources :projects, :only => [:new,:create,:edit,:update]

end
