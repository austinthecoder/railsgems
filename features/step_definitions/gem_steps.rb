Given /^the gem "([^"]*)" does not exist$/ do |arg1|
  RubyGems::Gem::MISSING_GEMS << arg1
end