Study::Application.routes.draw do
  resources :glossaries, :only => [:show,:index,:edit,:update]
  resources :sentences, :only => [:show,:index,:new,:create,:edit,:update]
  root :to => 'glossaries#index'
end
