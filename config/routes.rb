Railsgems::Application.routes.draw do

  resources :rails_gems, :only => %w(index create show update), :path => 'gems' do
    resource :tags, :only => %w(edit)
  end

  get 'about', :to => "pages#about", :as => 'about'

  root :to => "pages#home"

end