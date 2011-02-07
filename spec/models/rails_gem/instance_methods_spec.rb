require 'spec_helper'

def strings_containing_no_tags
  [nil, '', ' ', ' , ']
end

def strings_containing_one_tag
  [' one', 'one ', ' one ', ',one', 'one,', ',one,']
end

def strings_containing_two_tags
  ['one,two', 'one two', 'one ,  two']
end

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
      [nil, nil],
      ['', nil],
      [' ', nil],
      [' , ', nil],
      [' one', 'one'],
      ['one ', 'one'],
      [' one ', 'one'],
      [',one', 'one'],
      ['one,', 'one'],
      [',one,', 'one'],
      ['one,two', 'one two'],
      ['one two', 'one two'],
      ['one ,  two', 'one two'],
      ['one two one', 'one two']
    ].each do |given_tags, tags|
      context "when the given tags are #{tags.inspect}" do
        it "sets the tags to #{tags.inspect}" do
          rg.tags = given_tags
          rg.tags.should eq(tags)
        end
      end
    end
  end

  describe "#tags_array" do
    [
      [nil, []],
      ['', []],
      ['one', %w(one)],
      [%w(one two).join(' '), %w(one two)]
    ].each do |tags, tags_array|
      context "when the tags are #{tags.inspect}" do
        before { rg.tags = tags }

        it { rg.tags_array.should eq(tags_array) }
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
        [nil, nil],
        ['', nil],
        [' ', nil],
        [' , ', nil],
        [' one', 'one'],
        ['one ', 'one'],
        [' one ', 'one'],
        [',one', 'one'],
        ['one,', 'one'],
        [',one,', 'one'],
        ['one,two', 'one two'],
        ['one two', 'one two'],
        ['one ,  two', 'one two'],
        ['one two one', 'one two']
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
        [nil, 'one two'],
        ['', 'one two'],
        [' ', 'one two'],
        [' , ', 'one two'],
        [' three', 'one two three'],
        ['three ', 'one two three'],
        [' three ', 'one two three'],
        [',three', 'one two three'],
        ['three,', 'one two three'],
        [',three,', 'one two three'],
        ['three,four', 'one two three four'],
        ['three four', 'one two three four'],
        ['three ,  four', 'one two three four'],
        ['one three four', 'one two three four']
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
            rg.tags.should be_nil
          end
        end
      end
    end

    context "when the existing tags are 'one two'" do
      before { rg.tags = 'one two' }

      [
        [[], 'one two'],
        [['one'], 'two'],
        [['one', 'two'], nil],
        [['one', 'three'], 'two'],
        [['four', 'three'], 'one two'],
        [['one', 'three', 'two', 'four'], nil]
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

end