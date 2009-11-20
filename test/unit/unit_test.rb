require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  fixtures :units, :specifications, :attr_types

  def setup
    @valid_unit = units(:meter)
  end

  #make sure setup variables are valid
  #-----------------------------------
  def test_test_valid_unit_should_be_valid
    assert @valid_unit.valid?
  end

  #test relations
  #--------------
  #has_many :specifications
  def test_should_know_which_specifications_belongs_to_it
    assert_equal([@valid_unit.id], @valid_unit.specifications.collect {|s| s.unit_id})
  end

  #belongs_to :attr_type
  def test_should_know _which_attr_type_it_belongs_to
    assert_equal @valid_unit.attr_type_id, @valid_unit.attr_type.id
  end

  #test validations
  #----------------
  #validates_presence_of :name
  def test_should_not_be_valid_without_name
    @valid_unit.name = nil
    assert !@valid_unit.valid?
  end

  #validates_presence_of :attr_type_id
  def test_should_not_be_valid_without_attr_type_id
    @valid_unit.attr_type_id = nil
    assert !@valid_unit.valid?
  end

  #validates_uniqueness_of :name
  def test_new_unit_should_be_valid_if_name_and_abbrev_are_unique
    @new_unit = @valid_unit.clone
    @new_unit.name = "unique"
    @new_unit.abbrev = "unique"
    assert @new_unit.valid?
  end

  def test_new_unit_should_not_be_valid_if_name_is_duplicate
    @new_unit = @valid_unit.clone
    @new_unit.abbrev = "unique"
    assert !@new_unit.valid?
  end

  def test_new_unit_should_not_be_valid_if_abbrev_is_duplicate
    @new_unit = @valid_unit.clone
    @new_unit.name = "unique"
    assert !@new_unit.valid?
  end

  #validates_uniqueness_of :abbrev, :allow_nil => true
  def test_new_unit_should_be_valid_if_abbrev_is_nil
    @new_unit = @valid_unit.clone
    @new_unit.name = "unique"
    @new_unit.abbrev = nil
    assert @new_unit.valid?
  end

  def test_new_unit_should_not_be_valid_if_duplicate_of_any_valid_unit
    @new_unit = @valid_unit.clone
    assert !@new_unit.valid?
  end

  #before_destroy
  #--------------
  #errors.add_to_base "errors.add_to_base "Unit is referenced. Cannot delete." unless @check.nil?
  def test_should_not_be_destroyed_if_referenced
    assert_no_difference 'Unit.count' do
      @valid_unit.destroy
    end
  end
  def test_should_be_destroyed_if_not_referenced
    @new_unit = Unit.create(:name => "new", :attr_type_id => "123")
    assert_difference 'Unit.count', -1 do
      @new_unit.destroy
    end
  end
end
