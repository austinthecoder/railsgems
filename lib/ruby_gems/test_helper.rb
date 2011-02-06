require 'webmock'

module RubyGems
  module TestHelper

    extend WebMock::API

    class << self
      def make_gem_exist!(attrs = {})
        attrs.reverse_merge!(
          :name => 'some-gem',
          :version => '1.0.0',
          :info => 'some info for the gem'
        )

        raw_response = %|
HTTP/1.1 200 OK
Date: Fri, 04 Feb 2011 18:28:19 GMT
Server: Apache/2.2.3 (Red Hat) mod_ssl/2.2.3 OpenSSL/0.9.8e-fips-rhel5 Phusion_Passenger/3.0.0
X-Powered-By: Phusion Passenger (mod_rails/mod_rack) 3.0.0
ETag: "20b402ea8d85b4a2d84c36794a367fe9"
X-UA-Compatible: IE=Edge,chrome=1
X-Runtime: 0.013897
Cache-Control: max-age=0, private, must-revalidate
Status: 200
Transfer-Encoding: chunked
Content-Type: application/json; charset=utf-8

{"dependencies":{"runtime":[],"development":[{"name":"rspec","requirements":">= 2"}]},"name":"#{attrs[:name]}","downloads":545,"info":"#{attrs[:info]}","version_downloads":73,"version":"#{attrs[:version]}","homepage_uri":"http://github.com/some_user/#{attrs[:name]}","bug_tracker_uri":null,"source_code_uri":null,"gem_uri":"http://rubygems.org/gems/#{attrs[:name]}-#{attrs[:version]}.gem","project_uri":"http://rubygems.org/gems/#{attrs[:name]}","authors":"John Smith","mailing_list_uri":null,"documentation_uri":null,"wiki_uri":null}
        |
        stub_request(:get, "http://rubygems.org/api/v1/gems/#{attrs[:name]}.json").to_return(raw_response.strip)
      end

      def make_gem_not_exist!(attrs = {})
        raw_response = %|
HTTP/1.1 404 Not Found
Date: Fri, 04 Feb 2011 18:35:39 GMT
Server: Apache/2.2.3 (Red Hat) mod_ssl/2.2.3 OpenSSL/0.9.8e-fips-rhel5 Phusion_Passenger/3.0.0
X-Powered-By: Phusion Passenger (mod_rails/mod_rack) 3.0.0
X-UA-Compatible: IE=Edge,chrome=1
X-Runtime: 0.005015
Cache-Control: no-cache
Status: 404
Transfer-Encoding: chunked
Content-Type: application/json; charset=utf-8

This rubygem could not be found.
        |

        stub_request(:get, "http://rubygems.org/api/v1/gems/#{attrs[:name]}.json").to_return(raw_response.strip)
      end
    end

  end
end