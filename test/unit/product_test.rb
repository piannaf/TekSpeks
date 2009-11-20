require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products, :brands, :categories, :specifications

  def setup
    @valid_product = products(:product_with_name_brand)
  end

  #make sure setup variables are valid
  #-----------------------------------
  def test_valid_product_should_be_valid
    assert @valid_product.valid?
  end

  #test relations
  #--------------
  #belongs_to :brand
  def test_should_know_which_brand_it_belongs_to
    assert_equal(@valid_product.brand_id, @valid_product.brand.id)
  end

#  has_and_belongs_to_many :categories
  def test_should_know_how_many_categories_belong_to_it
    assert_equal(2, @valid_product.categories.count)
  end

  def test_should_access_category_attributes_across_the_association
    assert_equal("child", @valid_product.categories.sort_by { |c| c.category }.first.category)
  end

  #has_and_belongs_to_many :specifications
  def test_should_know_how_many_specifications_it_belongs_to
    assert_equal(1, @valid_product.specifications.count)
  end

  def test_should_access_specification_attributes_across_the_association
    assert_equal("25", @valid_product.specifications.sort_by { |s| }.first.spec_value)
  end

  #test validations
  #----------------
  #  validates_presence_of :name
  def test_should_not_be_valid_without_a_name
    @valid_product.name = nil
    assert !@valid_product.valid?
  end

  #  validates_uniqueness_of :name, :scope => :brand_id
  def test_new_product_should_be_valid_if_name_is_unique
    @new_product = @valid_product.clone
    @new_product.name = "unique"
    assert @new_product.valid?
  end

  def test_new_product_should_be_valid_if_brand_id_is_unique
    @new_product = @valid_product.clone
    @new_product.brand_id = 314159
    assert @new_product.valid?
  end

  def test_new_product_should_not_be_valid_if_duplicate_of_another_product
    @new_product = Product.new(
      :name => @valid_product.name, :brand_id => @valid_product.brand_id)
    assert !@new_product.valid?
  end
end
