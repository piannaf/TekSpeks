class RemoveProductIdFromSpecificationsAndRenameSpecAttributeIdToSpecAttributeAsString < ActiveRecord::Migration
  def self.up
    remove_column(:specifications, :product_id)
    rename_column(:specifications, :spec_attribute_id, :spec_attribute)
    change_column(:specifications, :spec_attribute, :string)
  end

  def self.down
    change_column(:specifications, :spec_attribute, :integer)
    rename_column(:specifications, :spec_attribute, :spec_attribute_id)
    add_column :specifications, :product_id, :integer
  end
end
