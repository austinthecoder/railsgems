require 'spec_helper'

describe RailsGem, "instance methods" do

  let(:rg) { Factory.build(:rails_gem) }

  describe "#==" do
    context "when it is a new record" do
      context "when the comparison object is a new record" do
        let(:other_rg) { Factory.build(:rails_gem) }

        context "when the attributes are the same" do
          it { rg.should eq(other_rg) }
        end

        context "when the attributes are different" do
          before { other_rg.name = 'something else' }

          it { rg.should_not eq(other_rg) }
        end
      end
    end
  end

end