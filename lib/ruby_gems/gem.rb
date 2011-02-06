module RubyGems
  class Gem < Hashie::Mash

    include HTTParty

    base_uri 'rubygems.org'

    class << self
      def find(name)
        response = get("/api/v1/gems/#{name}.json")
        if response.code == 200
          new(response)
        elsif response.code != 404
          raise "Unknown error finding gem"
        end
      end
    end

  end
end