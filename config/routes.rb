Study::Application.routes.draw do
  resources :glossaries, :only => [:index,:edit,:update]
  resources :sentences, :only => [:new,:create,:edit,:update,:index]
  root :to => 'glossaries#index'
end
