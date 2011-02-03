class RailsGem < ActiveRecord::Base

  acts_as_taggable

  # normalize_attribute :name

  # validates :name, :uniqueness => true

  def ==(other)
    if new_record? && other.new_record?
      attributes == other.attributes
    else
      super
    end
  end

end