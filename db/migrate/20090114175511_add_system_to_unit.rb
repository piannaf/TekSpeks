class AddSystemToUnit < ActiveRecord::Migration
  def self.up
    add_column :units, :system, :string
  end

  def self.down
    remove_column :units, :system
  end
end
