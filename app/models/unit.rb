class Unit < ActiveRecord::Base
  before_destroy :check_references

  #define relations
  has_many :specifications
  belongs_to :attr_type

  #define validations
  validates_presence_of :name
  validates_presence_of :attr_type_id
  validates_uniqueness_of :name
  validates_uniqueness_of :abbrev, :allow_nil => true

	def check_references
	  @check = self.specifications.find(:first)
	  errors.add_to_base "Unit is referenced. Cannot delete." unless @check.nil?
	  @check.nil?
	end
end