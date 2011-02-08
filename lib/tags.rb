class Tags

  include Comparable

  def initialize(str_or_enum)
    str = str_or_enum.is_a?(Enumerable) ? str_or_enum.join(' ') : str_or_enum.to_s
    @tags = Set.new(str.gsub(/,/, ' ').gsub(/\s+/, ' ').strip.split(' '))
  end

  def to_s
    to_a.join(' ')
  end

  def -(other)
    (tags - other.to_tags.send(:tags)).to_tags
  end

  def +(other)
    (tags + other.to_tags.send(:tags)).to_tags
  end

  def <=>(other)
    tags <=> other.send(:tags)
  end

  def to_tags
    self
  end

  delegate :each, :empty?, :to_a, :to => :tags

  private

  attr_reader :tags

end

class NilClass
  def to_tags
    Tags.new(self)
  end
end

class String
  def to_tags
    Tags.new(self)
  end
end

class Array
  def to_tags
    Tags.new(self)
  end
end

class Set
  def to_tags
    to_a.to_tags
  end
end