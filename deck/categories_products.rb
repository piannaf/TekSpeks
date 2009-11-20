class CategoriesProducts < ActiveRecord::Base
  #define relations
  belongs_to :product
  belongs_to :category

  #define validations
  validates_presence_of :category_id
  validates_presence_of :product_id

  validates_uniqueness_of :product_id, :scope => :category_id
end
