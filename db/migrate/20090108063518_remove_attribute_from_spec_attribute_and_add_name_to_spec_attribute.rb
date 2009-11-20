class RemoveAttributeFromSpecAttributeAndAddNameToSpecAttribute < ActiveRecord::Migration
  def self.up
    remove_column :spec_attributes, :attribute
    add_column :spec_attributes, :name, :string
  end

  def self.down
    add_column :spec_attributes, :attribute, :string
    remove_column :spec_attributes, :name
  end
end
