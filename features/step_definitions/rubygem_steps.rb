Given /^a rubygem exists with the attributes:$/ do |table|
  RubyGems::TestHelper.make_gem_exist!(table.rows_hash.symbolize_keys)
end

Given /^a rubygem does not exist named "([^"]*)"$/ do |gem_name|
  RubyGems::TestHelper.make_gem_not_exist!(:name => gem_name)
end

Given /^a rubygem exists named "([^"]*)"$/ do |gem_name|
  RubyGems::TestHelper.make_gem_exist!(:name => gem_name)
end