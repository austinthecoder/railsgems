Given /^gems have been added with the attributes:$/ do |table|
  table.hashes.each do |attrs|
    RailsGem.create!(attrs)
  end
end

Given /^a gem has been added with the attributes:$/ do |table|
  attrs = table.transpose.map_headers(
    # 'tags' => 'tag_list'
  ).transpose.rows_hash.symbolize_keys

  RailsGem.create!(attrs)
end

##################################################

When /^I visit the page for (that gem)$/ do |gem|
  visit rails_gem_path(gem)
end

##################################################

Then /^the search results should include gems "([^"]*)"$/ do |gems|
  gems = gems.split(', ')
  with_scope('.gems') do
    gems.each do |gem|
      page.should have_content(gem)
    end
  end
end

When /^the search results should not include gems "([^"]*)"$/ do |gems|
  gems = gems.split(', ')
  with_scope('.gems') do
    gems.each do |gem|
      page.should_not have_content(gem)
    end
  end
end