class TagsController < ApplicationController

  def edit
    @rails_gem = RailsGem.find(params[:rails_gem_id])
  end

end