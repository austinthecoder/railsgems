class RailsGem < ActiveRecord::Base

  acts_as_taggable

  normalize_attribute :name

  validates :name, :presence => true, :uniqueness => {:message => 'has already been added!'}

  validate do
    unless name.blank?
      case name
      when /^[^a-z]*$/i
        errors.add(:name, "must include at least one letter")
      when /[^\w\-]+/i
        errors.add(:name, "can only include letters, numbers, dashes, and underscores")
      else
        unless RubyGems::Gem.find(name)
          errors.add(:base, "That gem does not exist")
        end
      end
    end
  end

  def ==(other)
    if new_record? && other.new_record?
      attributes == other.attributes
    else
      super
    end
  end

end