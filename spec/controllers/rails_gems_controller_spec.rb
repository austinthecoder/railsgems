require 'spec_helper'

describe RailsGemsController do

  # describe "#find_rails_gem" do
  #   before { controller.stub!(:params => {:id => '5427309'}) }
  #
  #   context "when a rails gems exists for the id" do
  #     before { @rg = Factory(:rails_gem, :id => 5427309) }
  #
  #     it "assigns the rails gem" do
  #       controller.find_rails_gem
  #       assigns(:rails_gem).should eq(@rg)
  #     end
  #   end
  #
  #   context "when a rails gem does not exist for the id" do
  #     it "should"
  #   end
  # end

  describe "POST create" do
    context "with valid params" do
      before do
        @params = {:rails_gem => {:name => 'gem1', :tag_list => "some, tags, here"}}
      end

      it "creates a rails gem" do
        post :create, @params
        rg = RailsGem.last
        rg.name.should eq('gem1')
        rg.tag_list.should eq(['here', 'tags', 'some'])
      end

      it "assigns the rails gem" do
        post :create, @params
        assigns(:rails_gem).should eq(RailsGem.last)
      end

      it "redirects to the gem's page" do
        post :create, @params
        response.should redirect_to rails_gem_url(RailsGem.last)
      end
    end

    context "with invalid params" do
      it "does not create a rails gem" do
        post :create, @params
        RailsGem.count.should eq(0)
      end

      it "renders the home page" do
        post :create, @params
        response.should render_template('pages/home')
      end
    end
  end

end
