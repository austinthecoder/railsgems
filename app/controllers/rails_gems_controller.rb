class RailsGemsController < ApplicationController

  def create
    @rails_gem = RailsGem.new(params[:rails_gem])
    if @rails_gem.save
      flash.notice = "Thanks for adding #{@rails_gem.name}!"
      redirect_to rails_gem_url(@rails_gem)
    else
      flash[:error] = "There were some errors, see below."
      render 'pages/home'
    end
  end

end
