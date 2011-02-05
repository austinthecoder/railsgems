require 'spec_helper'

describe RailsGem do

  describe "normalizations" do
    it { should normalize_attribute(:name) }
  end

  describe "validations" do
    let(:rg) { Factory.build(:rails_gem) }

    context "when a rails gem exists with the same name" do
      before { Factory(:rails_gem, :name => rg.name) }

      it { rg.should have(1).error_on(:name) }
    end

    context "when the name contains a non letter, number, dash, or underscore" do
      before { rg.name = "my.cool-gem" }

      it { rg.should have(1).error_on(:name) }
    end

    context "when the name doesn't contain a letter" do
      before { rg.name = "97-98734_4579" }

      it { rg.should have(1).error_on(:name) }
    end
  end

end
