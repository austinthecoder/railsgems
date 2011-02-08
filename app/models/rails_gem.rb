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

  def tags=(tags)
    self[:tags] = normalize_tags(tags)
  end

  def tags_array
    tags.to_s.split(' ')
  end

  def additional_tags
    nil
  end

  # TODO: more flexibility
  # the feature requires this to take a string
  # it would be nice to accept both string and array
  def additional_tags=(addl_tags)
    self.tags = normalize_tags("#{tags} #{addl_tags}")
  end

  # TODO: more flexibility
  # the feature requires this to take an array
  # it would be nice to accept both array and string
  def subtractional_tags=(sub_tags_array)
    self.tags = (tags_array - normalize_tags(sub_tags_array.join(' ')).to_s.split(' ')).join(' ')
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

  def normalize_tags(tags)
    tags.to_s.gsub(/,/, ' ').gsub(/\s+/, ' ').strip.split(' ').uniq.join(' ').presence
  end

  def valid_name_format?
    # present, contains a letter, and doesn't contain non word/dash chars
    name.present? && (name =~ /[a-z]/i) && (name =~ /^[\w\-]+$/i)
  end

end