class RenameCategorizationsToCategoriesProducts < ActiveRecord::Migration
  def self.up
    rename_table(:categorizations, :categories_products)
  end

  def self.down
    rename_table(:categories_products, :categorizations)
  end
end
