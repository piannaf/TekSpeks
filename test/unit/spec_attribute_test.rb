require 'test_helper'

class SpecAttributeTest < ActiveSupport::TestCase
  fixtures :spec_attributes, :specifications, :attr_types

  def setup
    @valid_spec_attribute = spec_attributes(:height)
  end

  #make sure setup variables are valid
  #-----------------------------------
  def test_valid_spec_attribute_should_be_valid
    assert @valid_spec_attribute.valid?
  end

  #test relations
  #--------------
  #has_many :specifications
  def test_should_know_which_specifications_belong_to_it
    assert_equal([@valid_spec_attribute.id],
      @valid_spec_attribute.specifications.collect {|s| s.spec_attribute_id})
  end
  #belongs_to :attr_type
  def test_should_know_which_attr_type_it_belongs_to
    assert_equal @valid_spec_attribute.attr_type_id, @valid_spec_attribute.attr_type.id
  end

  #test validations
  #----------------
  #validates_presence of :name
  def test_should_not_be_valid_without_name
    @valid_spec_attribute.name = nil
    assert !@valid_spec_attribute.valid?
  end

  #validates_presence of :attr_type_id
  def test_should_not_be_valid_without_attr_type_id
    @valid_spec_attribute.attr_type_id = nil
    assert !@valid_spec_attribute.valid?
  end

  #validates_uniqueness of :name
  def test_new_spec_attribute_should_be_valid_if_name_is_unique
    @new_spec_attribute = @valid_spec_attribute.clone
    @new_spec_attribute.name = "unique"
    assert @new_spec_attribute.valid?
  end
  def test_new_spec_attribute_should_not_be_valid_if_name_is_duplicate
    @new_spec_attribute = SpecAttribute.new(:name => @valid_spec_attribute.name,
      :attr_type_id => 12345)
    assert !@new_spec_attribute.valid?
  end

  #before_destroy
  #--------------
  #errors.add_to_base "Attribute is referenced. Cannot delete." unless @check.nil?
  def test_should_not_be_destroyed_if_referenced
    assert_no_difference 'SpecAttribute.count' do
      @valid_spec_attribute.destroy
    end
  end
  def test_should_be_destroyed_if_not_referenced
    @new_spec_attribute = SpecAttribute.create(:name => "new", :attr_type_id => 12345)
    assert_difference 'SpecAttribute.count', -1 do
      @new_spec_attribute.destroy
    end
  end
end
