class RailsGemsController < ApplicationController

  before_filter :find_rails_gem, :only => %w(show update)

  def index
    @search = RailsGem.search(params[:search])
    @results = params[:search].present? ? @search.all : RailsGem.all
  end

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

  def update
    @rails_gem.update_attributes!(params[:rails_gem])
    redirect_to rails_gem_url(@rails_gem)
  end

  ##################################################
  private

  def find_rails_gem
    @rails_gem = RailsGem.find(params[:id])
  end

end