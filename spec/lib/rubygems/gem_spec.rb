require 'spec_helper'

describe RubyGems::Gem do

  describe ".find" do
    context "when a ruby gem exists for the name" do
      before do
        @gem_attrs = {
          :name => 'some-gem',
          :version => '1.2.3',
          :info => 'the gem info'
        }
        RubyGems::TestHelper.make_gem_exist!(@gem_attrs)
      end

      it "it returns the gem" do
        rg = RubyGems::Gem.find('some-gem')
        {
          :name => rg.name,
          :version => rg.version,
          :info => rg.info
        }.should eq(@gem_attrs)
      end
    end

    context "when a ruby gem does not exist for the name" do
      before { RubyGems::TestHelper.make_gem_not_exist!(:name => 'bad-gem') }

      it { RubyGems::Gem.find('bad-gem').should be_nil }
    end

    context "when an unexpected status code is returned" do
      before do
        url = "http://rubygems.org/api/v1/gems/some-gem.json"
        RubyGems::TestHelper.stub_request(:get, url).to_return(:status => 500)
      end

      it "raises an error" do
        lambda do
          RubyGems::Gem.find('some-gem')
        end.should raise_error("Unknown error finding gem")
      end
    end
  end

end