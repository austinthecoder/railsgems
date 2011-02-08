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

When /^I fill in text box with "([^"]*)" within tags$/ do |value|
  with_scope(".tags") do
    fill_in("rails_gem[additional_tags]", :with => value)
  end
end

##################################################

Then /^I should see "([^"]*)" within tags$/ do |text|
  with_scope(".tags") do
    page.should have_content(text)
  end
end

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