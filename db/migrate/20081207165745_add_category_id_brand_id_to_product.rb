class AddCategoryIdBrandIdToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :category_id, :integer
    add_column :products, :brand_id, :integer
  end

  def self.down
    remove_column :products, :brand_id
    remove_column :products, :category_id
  end
end
