class PagesController < ApplicationController

  caches_page :about

  def home
    @rails_gem = RailsGem.new
  end

end