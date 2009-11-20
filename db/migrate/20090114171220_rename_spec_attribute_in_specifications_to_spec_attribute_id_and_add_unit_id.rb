class RenameSpecAttributeInSpecificationsToSpecAttributeIdAndAddUnitId < ActiveRecord::Migration
  def self.up
    rename_column(:specifications, :spec_attribute, :spec_attribute_id)
    change_column :specifications, :spec_attribute_id, :integer
    add_column :specifications, :unit_id, :integer
  end

  def self.down
    remove_column(:specifications, :unit_id)
    change_column :specifications, :spec_attribute_id, :string
    rename_column(:specifications, :spec_attribute_id, :spec_attribute)
  end
end
