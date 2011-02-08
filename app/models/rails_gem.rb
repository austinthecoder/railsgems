class RailsGem < ActiveRecord::Base

  ERROR_MSGS = {
    :not_unique => 'has already been added!',
    :bad_format => 'must be a combination of letters, numbers, dashes, and underscores (with at least one letter)',
    :not_exists => 'That gem does not exist'
  }

  normalize_attribute :name

  ### validations ###
  validate do
    unless valid_name_format?
      errors.add(:name, ERROR_MSGS[:bad_format])
    end
  end
  validates :name, :uniqueness => {
    :message => ERROR_MSGS[:not_unique],
    :if => :valid_name_format?
  }
  validate do
    if valid_name_format? && errors[:name].exclude?(ERROR_MSGS[:not_unique])
      unless RubyGems::Gem.find(name)
        errors.add(:base, ERROR_MSGS[:not_exists])
      end
    end
  end

  ### instance methods ###
  def ==(other)
    if new_record? && other.new_record?
      attributes == other.attributes
    else
      super
    end
  end

  def tags
    Tags.new(self[:tags])
  end

  def tags=(tags)
    self[:tags] = Tags.new(tags)
  end

  def additional_tags
    nil
  end

  def additional_tags=(addl_tags)
    self.tags = tags + addl_tags
  end

  def subtractional_tags=(sub_tags)
    self.tags = tags - sub_tags
  end

  def rubygem
    @rubygem = RubyGems::Gem.find(name) unless defined?(@rubygem)
    @rubygem
  end

  delegate :version, :to => :rubygem

  def rubygem_url
    rubygem.project_uri
  end

  def description
    rubygem.info
  end

  def to_param
    name if id
  end

  private

  def valid_name_format?
    # present, contains a letter, and doesn't contain non word/dash chars
    name.present? && (name =~ /[a-z]/i) && (name =~ /^[\w\-]+$/i)
  end

end