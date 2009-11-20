require 'test_helper'

class SpecificationTest < ActiveSupport::TestCase
  fixtures :specifications, :products, :spec_attributes, :units

  def setup
    @valid_specification = specifications(:specification_with_spec_value_spec_attribute_product)
  end

  #make sure setup variables are valid
  #-----------------------------------
  def test_valid_specification_should_be_valid
    assert @valid_specification.valid?
  end

  #test relations
  #--------------
  #
  #has_and_belongs_to_many :products
  def test_should_know_how_many_products_it_belongs_to
    assert_equal(1, @valid_specification.products.count)
  end

  def test_should_access_product_attributes_across_the_association
    assert_equal("product_name_one", @valid_specification.products.sort_by { |p| p.name }.first.name)
  end

  #belongs_to :spec_attribute
  def test_should_know_which_spec_attribute_it_belongs_to
    assert_equal(@valid_specification.spec_attribute_id, @valid_specification.spec_attribute.id)
  end

  #belongs_to :unit
  def test_should_know_which_unit_it_belongs_to
    assert_equal(@valid_specification.unit_id, @valid_specification.unit.id)
  end

  #test validations
  #----------------
	#validates_presence_of :spec_attribute_id, :unit_id,
   #:message => "Please specify attribute and unit or none at all.", 
   #:unless => :descriptive
  def test_should_be_valid_with_no_attribute_and_no_unit
  	@valid_specification.spec_attribute_id = nil
  	@valid_specification.unit_id = nil
  	assert @valid_specification.valid?
	end
	
	def test_should_not_be_valid_with_attribute_but_no_unit
		@valid_specification.unit_id = nil
		assert !@valid_specification.valid?
	end
	
	def test_should_not_be_valid_with_unit_but_no_attribute
		@valid_specification.spec_attribute_id = nil
		assert !@valid_specification.valid?
	end

  #validates_presence_of spec_value
  def test_should_not_be_valid_without_spec_value
    @valid_specification.spec_value = nil
    assert !@valid_specification.valid?
  end
  
  #  validates_uniqueness_of :spec_value, :scope => [:spec_attribute_id, :unit_id]
  def test_new_specification_should_be_valid_with_unique_spec_value
    @new_specification = @valid_specification.clone
    @new_specification.spec_value = "12345"
    assert @new_specification.valid?
  end

  def test_new_specification_should_be_valid_with_unique_spec_attribute_id
    @new_specification = @valid_specification.clone
    @new_specification.spec_attribute_id = spec_attributes(:width).id
    assert @new_specification.valid?
  end

  def test_new_specification_should_be_valid_with_unique_unit_id
    @new_specification = @valid_specification.clone
    @new_specification.unit_id = units(:inch).id
    assert @new_specification.valid?
  end

  def test_new_specification_should_not_be_valid_if_duplicating_spec_value_and_spec_attribute
    @new_specification = Specification.new(
      :spec_value => @valid_specification.spec_value,
      :spec_attribute_id => @valid_specification.spec_attribute_id,
      :unit_id => @valid_specification.unit_id )
    assert !@new_specification.valid?
  end
  
  #errors.add_to_base "Attribute and Unit must be of the same attr_type." unless self.spec_attribute.attr_type == self.unit.attr_type
	def test_new_specification_should_not_be_valid_if_attribute_and_unit_are_different_attr_types
		@new_specification = Specification.new(
      :spec_value => @valid_specification.spec_value,
      :spec_attribute_id => spec_attributes(:height).id,
      :unit_id => units(:pound).id )
    assert !@new_specification.valid?
	end
  
  #before_destroy
  #--------------
  #errors.add_to_base "errors.add_to_base "Specification is referenced. Cannot delete." unless @check.nil?
  def test_should_not_be_destroyed_if_referenced
    assert_no_difference 'Specification.count' do
      @valid_specification.destroy
    end
  end
  def test_should_be_destroyed_if_not_referenced
    @new_specification = Specification.create(:spec_value => "new")
    assert_difference 'Specification.count', -1 do
      @new_specification.destroy
    end
  end
end
