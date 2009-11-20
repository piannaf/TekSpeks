class RenameTypes < ActiveRecord::Migration
  def self.up
    rename_table(:types, :attr_types)
  end

  def self.down
    rename_table(:attr_types, :types)
  end
end
