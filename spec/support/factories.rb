FactoryGirl.define do
  factory :rails_gem do
    name "gem1"
  end
end

RubyGems::TestHelper.make_gem_exist!(:name => 'gem1')