class CreateProductsSpecifications < ActiveRecord::Migration
  def self.up
    create_table :products_specifications do |t|
      t.integer :product_id
      t.integer :specification_id

      t.timestamps
    end
  end

  def self.down
    drop_table :products_specifications
  end
end
