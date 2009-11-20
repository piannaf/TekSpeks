require 'test_helper'

class BrandTest < ActiveSupport::TestCase
  fixtures :brands, :products

  def setup
    @valid_brand = brands(:brand_with_name)
  end

  #make sure setup variables are valid
  #-----------------------------------
  def test_valid_brand_should_be_valid
    assert @valid_brand.valid?
  end

  #test relations
  #--------------
  #
  #has_many :products
  def test_should_know_which_products_belong_to_it
    assert_equal([@valid_brand.id], @valid_brand.products.collect {|p| p.brand_id})
  end

  #test validations
  #----------------
  #
  #validates_presence_of :name
  def test_should_not_be_valid_without_a_name
    @valid_brand.name = nil
    assert !@valid_brand.valid?
  end
  
  #validates_uniquenes_of :name
  def test_new_brand_should_be_valid_if_name_is_unique
    @new_brand = @valid_brand.clone
    @new_brand.name = "unique"
    assert @new_brand.valid?
  end

  def test_new_brand_should_not_be_valid_if_name_is_duplicate
    @new_brand = Brand.new(:name => @valid_brand.name)
    assert !@new_brand.valid?
  end

  #before_destroy
  #--------------
  #errors.add_to_base "errors.add_to_base "Brand is referenced. Cannot delete." unless @check.nil?
  def test_should_not_be_destroyed_if_referenced
    assert_no_difference 'Brand.count' do
      @valid_brand.destroy
    end
  end
  def test_should_be_destroyed_if_not_referenced
    @new_brand = Brand.create(:name => "new")
    assert_difference 'Brand.count', -1 do
      @new_brand.destroy
    end
  end
end
