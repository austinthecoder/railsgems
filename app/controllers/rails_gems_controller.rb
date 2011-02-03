class RailsGemsController < ApplicationController

  def create
    @rails_gem = RailsGem.new(params[:rails_gem])
    if @rails_gem.save
      flash.notice = "Thanks for adding #{@rails_gem.name}!"
      redirect_to rails_gem_url(@rails_gem)
    else
      render root_url
    end
  end

end
