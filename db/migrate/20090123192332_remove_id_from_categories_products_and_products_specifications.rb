class RemoveIdFromCategoriesProductsAndProductsSpecifications < ActiveRecord::Migration
  def self.up
    drop_table :products_specifications
    create_table :products_specifications, :id => false do |t|
      t.integer :product_id
      t.integer :specification_id

      t.timestamps
    end
    drop_table :categories_products
    create_table :categories_products, :id => false do |t|
      t.integer :product_id
      t.integer :category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :products_specifications
    create_table :products_specifications do |t|
      t.integer :product_id
      t.integer :specification_id

      t.timestamps
    end
    drop_table :categories_products
    create_table :categories_products do |t|
      t.integer :product_id
      t.integer :category_id

      t.timestamps
    end
  end
end
