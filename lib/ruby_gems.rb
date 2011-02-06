require 'ruby_gems/gem'

if Rails.env.test?
  require 'ruby_gems/test_helper'
end