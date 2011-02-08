class TagsController < ApplicationController

  def edit
    @rails_gem = RailsGem.find_by_name!(params[:rails_gem_id])
  end

end