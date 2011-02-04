require 'webmock'

module HTTPStubbing

  extend WebMock::API

  class << self
    def perform
      %w(gem1 gem2 gem3 gem4).each do |gem_name|
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

{"dependencies":{"runtime":[],"development":[{"name":"rspec","requirements":">= 2"}]},"name":"#{gem_name}","downloads":545,"info":"Some info about the gem.","version_downloads":73,"version":"1.0.0","homepage_uri":"http://github.com/some_user/#{gem_name}","bug_tracker_uri":null,"source_code_uri":null,"gem_uri":"http://rubygems.org/gems/#{gem_name}-1.0.0.gem","project_uri":"http://rubygems.org/gems/#{gem_name}","authors":"John Smith","mailing_list_uri":null,"documentation_uri":null,"wiki_uri":null}
        |

        stub_request(:get, "http://rubygems.org/api/v1/gems/#{gem_name}.json").to_return(raw_response.strip)
      end
    end
  end

end