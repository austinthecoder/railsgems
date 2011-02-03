require 'spec_helper'

describe PagesController do

  describe "GET home" do
    it "should assign a new gem" do
      get :home
      assigns(:rails_gem).should eq(RailsGem.new)
    end
  end

end