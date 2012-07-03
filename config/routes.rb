Study::Application.routes.draw do
  resources :glossaries
  root :to => 'glossary#index'
end
