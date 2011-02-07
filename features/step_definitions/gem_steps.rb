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