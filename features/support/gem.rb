module RubyGems
  class Gem

    MISSING_GEMS = []

    class << self
      def find(name)
        new unless MISSING_GEMS.include?(name)
      end
    end

  end
end