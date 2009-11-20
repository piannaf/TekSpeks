class Product < ActiveRecord::Base
  #define relations
  belongs_to :brand
  
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :specifications

  #define validations
  validates_presence_of :name

  validates_uniqueness_of :name, :scope => :brand_id
end
