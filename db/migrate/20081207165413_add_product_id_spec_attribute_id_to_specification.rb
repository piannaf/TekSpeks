class AddProductIdSpecAttributeIdToSpecification < ActiveRecord::Migration
  def self.up
    add_column :specifications, :product_id, :integer
    add_column :specifications, :spec_attribute_id, :integer
  end

  def self.down
    remove_column :specifications, :spec_attribute_id
    remove_column :specifications, :product_id
  end
end
