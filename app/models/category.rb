class Category < ActiveRecord::Base
	before_validation :nil_to_zero
  before_destroy :check_references, :check_children
    
  #define relations
  has_and_belongs_to_many :products

  #define validations
  validates_presence_of :category
  validates_uniqueness_of :category, :scope => :parent_id

	def validate
		errors.add_to_base "Category cannot be a child of itself" if self.id == self.parent_id
	end

  #declare plugins
  acts_as_tree :order=>"category"
  
  def nil_to_zero
  	self.parent_id = 0 if self.parent_id.blank?
	end

	def check_references
	  @check =  self.products.find(:first)
	  errors.add_to_base "This category is referenced. Cannot delete." unless @check.nil?
    @check.nil?
	end
	
	def check_children
	  @check_children = self.children.first
	  errors.add_to_base "This catagory is a parent. Cannot delete." unless @check_children.nil?
		@check_children.nil?
	end
end
