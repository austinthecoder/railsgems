class PagesController < ApplicationController

  def home
    @rails_gem = RailsGem.new
  end

end