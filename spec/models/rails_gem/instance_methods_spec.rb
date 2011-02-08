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

  describe "#tags=" do
    [
      [nil, Tags.new(nil)],
      ['', Tags.new(nil)],
      [' ', Tags.new(nil)],
      [' , ', Tags.new(nil)],
      [' one', Tags.new('one')],
      ['one ', Tags.new('one')],
      [' one ', Tags.new('one')],
      [',one', Tags.new('one')],
      ['one,', Tags.new('one')],
      [',one,', Tags.new('one')],
      ['one,two', Tags.new('one two')],
      ['one two', Tags.new('one two')],
      ['one ,  two', Tags.new('one two')],
      ['one two one', Tags.new('one two')]
    ].each do |given_tags, tags|
      context "when the given tags are #{tags.inspect}" do
        it "sets the tags to #{tags.inspect}" do
          rg.tags = given_tags
          rg.tags.should eq(tags)
        end
      end
    end
  end

  describe "#additional_tags" do
    it { rg.additional_tags.should be_nil }
  end

  describe "#additional_tags=" do
    context "when there are no existing tags" do
      before { rg.tags = nil }

      [
        [nil, Tags.new(nil)],
        ['', Tags.new(nil)],
        [' ', Tags.new(nil)],
        [' , ', Tags.new(nil)],
        [' one', Tags.new('one')],
        ['one ', Tags.new('one')],
        [' one ', Tags.new('one')],
        [',one', Tags.new('one')],
        ['one,', Tags.new('one')],
        [',one,', Tags.new('one')],
        ['one,two', Tags.new('one two')],
        ['one two', Tags.new('one two')],
        ['one ,  two', Tags.new('one two')],
        ['one two one', Tags.new('one two')]
      ].each do |given_tags, tags|
        context "when the given tags are #{given_tags.inspect}" do
          it "sets the tags to #{tags.inspect}" do
            rg.additional_tags = given_tags
            rg.tags.should eq(tags)
          end
        end
      end
    end

    context "when the existing tags are 'one two'" do
      before { rg.tags = 'one two' }

      [
        [nil, Tags.new('one two')],
        ['', Tags.new('one two')],
        [' ', Tags.new('one two')],
        [' , ', Tags.new('one two')],
        [' three', Tags.new('one two three')],
        ['three ', Tags.new('one two three')],
        [' three ', Tags.new('one two three')],
        [',three', Tags.new('one two three')],
        ['three,', Tags.new('one two three')],
        [',three,', Tags.new('one two three')],
        ['three,four', Tags.new('one two three four')],
        ['three four', Tags.new('one two three four')],
        ['three ,  four', Tags.new('one two three four')],
        ['one three four', Tags.new('one two three four')]
      ].each do |given_tags, tags|
        context "when the given tags are #{given_tags.inspect}" do
          it "sets the tags to #{tags.inspect}" do
            rg.additional_tags = given_tags
            rg.tags.should eq(tags)
          end
        end
      end
    end
  end

  describe "#subtractional_tags=" do
    context "when there are no existing tags" do
      before { rg.tags = nil }

      [
        [],
        ['one'],
        ['one', 'two']
      ].each do |given_tags|
        context "when the given tags are #{given_tags.inspect}" do
          it "tags should remain as nil" do
            rg.subtractional_tags = given_tags
            rg.tags.should eq(Tags.new(nil))
          end
        end
      end
    end

    context "when the existing tags are 'one two'" do
      before { rg.tags = 'one two' }

      [
        [[], Tags.new('one two')],
        [['one'], Tags.new('two')],
        [['one', 'two'], Tags.new(nil)],
        [['one', 'three'], Tags.new('two')],
        [['four', 'three'], Tags.new('one two')],
        [['one', 'three', 'two', 'four'], Tags.new(nil)]
      ].each do |given_tags, tags|
        context "when the given tags are #{given_tags.inspect}" do
          it "sets the tags to #{tags.inspect}" do
            rg.subtractional_tags = given_tags
            rg.tags.should eq(tags)
          end
        end
      end
    end
  end

  describe "#to_param" do
    context "when unsaved" do
      it { rg.to_param.should be_nil }
    end

    context "when saved" do
      before { rg.save! }

      it { rg.to_param.should eq(rg.name) }
    end
  end

end