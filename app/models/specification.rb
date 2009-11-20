class Specification < ActiveRecord::Base
  before_destroy :check_references

  #define relations
  has_and_belongs_to_many :products
  belongs_to :spec_attribute
  belongs_to :unit

  #define validations
  validates_presence_of :spec_value
  validates_presence_of :spec_attribute_id, :unit_id,
   :message => "Please specify attribute and unit or none at all.", 
   :unless => :descriptive

  validates_uniqueness_of :spec_value, :scope => [:spec_attribute_id, :unit_id]

	def validate
		if !self.spec_attribute.blank? && !self.unit.blank?
			errors.add_to_base "Attribute and Unit must be of the same type." unless
		 	  self.spec_attribute.attr_type.id == self.unit.attr_type.id
		end
	end

	def check_references
	  @check = self.products.find(:first)
	  errors.add_to_base "Specification is referenced. Cannot delete." unless @check.nil?
	  @check.nil?
	end
	
	def descriptive
	 self.spec_attribute_id.nil? && self.unit_id.nil?	
	end
end
