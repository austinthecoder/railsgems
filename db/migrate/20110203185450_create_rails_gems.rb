class CreateRailsGems < ActiveRecord::Migration
  def self.up
    create_table :rails_gems do |t|
      t.string :name

      t.timestamps
    end

    add_index :rails_gems, :name, :unique => true
  end

  def self.down
    drop_table :rails_gems
  end
end
