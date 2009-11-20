require 'test_helper'

class AttrTypeTest < ActiveSupport::TestCase
  fixtures :attr_types, :units, :spec_attributes

  def setup
    @valid_attr_type = attr_types(:length)
  end

  #make sure setup variables are valid
  #-----------------------------------
  def test_valid_attr_type_should_be_valid
    assert @valid_attr_type.valid?
  end

  #test relations
  #--------------
  #has_many :spec_attributes
  def test_should_know_which_spec_attributes_belong_to_it
    assert_equal([@valid_attr_type.id]*2, @valid_attr_type.spec_attributes.collect {|s| s.attr_type_id})
  end

  #has_many :units
  def test_should_know_which_units_belong_to_it
    assert_equal([@valid_attr_type.id]*2, @valid_attr_type.units.collect {|u| u.attr_type_id})
  end
  
  #test validations
  #----------------
  #validates_presence_of :name
  def test_should_not_be_valid_without_a_name
    @valid_attr_type.name = nil
    assert !@valid_attr_type.valid?
  end
  #validates_uniqueness_of :name
  def test_new_attr_type_should_be_valid_if_name_is_unique
    @new_attr_type = @valid_attr_type.clone
    @new_attr_type.name = "unique"
    assert @new_attr_type.valid?
  end

  def test_new_attr_type_should_not_be_valid_if_name_is_duplicate
    @new_attr_type = @valid_attr_type.clone
    assert !@new_attr_type.valid?
  end

  #before_destroy
  #--------------
  #errors.add_to_base "errors.add_to_base "attr_type is referenced. Cannot delete." unless @check.nil?
  def test_should_not_be_destroyed_if_referenced
    assert_no_difference 'AttrType.count' do
      @valid_attr_type.destroy
    end
  end
  def test_should_be_destroyed_if_not_referenced
    @new_attr_type = AttrType.create(:name => "new")
    assert_difference 'AttrType.count', -1 do
      @new_attr_type.destroy
    end
  end
end
