module RubyGems
  class Gem < Hashie::Mash

    include HTTParty

    base_uri 'rubygems.org'

    class << self
      def find(name)
        response = get_by_name(name)
        if response.code == 200
          new(response)
        elsif response.code != 404
          raise "Error finding gem"
        end
      end

      def exists?(name)
        get_by_name(name).code == 200
      end

      def get_by_name(name)
        get("/api/v1/gems/#{name}.json")
      end
    end

  end
end