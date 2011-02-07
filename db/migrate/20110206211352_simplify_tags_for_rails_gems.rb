class SimplifyTagsForRailsGems < ActiveRecord::Migration
  def self.up
    drop_table :taggings
    drop_table :tags
    add_column :rails_gems, :tags, :string
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
