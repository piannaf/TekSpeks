class AttrType < ActiveRecord::Base
  before_destroy :check_references

  #define relations
  has_many :spec_attributes
  has_many :units

  #define validations
  validates_presence_of :name
  validates_uniqueness_of :name
  
	def check_references
	  @check = self.spec_attributes.find(:first) || self.units.find(:first)
	  errors.add_to_base "Type is referenced. Cannot delete." unless @check.nil?
	  @check.nil?
	end
end
