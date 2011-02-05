Railsgems::Application.routes.draw do

  resources :rails_gems, :only => %w(index create show update), :path => 'gems'

  root :to => "pages#home"

end