class Brand < ActiveRecord::Base
  before_destroy :check_references
  
  #define relations
  has_many :products

  validates_presence_of :name
  validates_uniqueness_of :name
end


	def check_references
	  @check = self.products.find(:first)
	  errors.add_to_base "Brand is referenced. Cannot delete." unless @check.nil?
	  @check.nil?
	end