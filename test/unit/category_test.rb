require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  fixtures :categories, :products

  def setup
    @valid_category = categories(:root_with_products_and_children)
    @valid_child_with_products = categories(:child_with_products)
    @valid_child_with_no_products = categories(:child_with_no_products)
    @valid_root_with_children_but_no_products = categories(:root_with_children_but_no_products)
  end

  #make sure setup variables are valid
  #-----------------------------------
  def test_valid_category_should_be_valid
    assert @valid_category.valid?
  end

  #test relations
  #--------------
  #has_and_belongs_to_many :products
  def test_should_know_how_many_products_belong_to_it
    assert_equal(2, @valid_category.products.count)
  end

  def test_should_access_attributes_across_the_association
    assert_equal("product_name_one", @valid_category.products.sort_by { |p| p.name }.first.name)
  end

  #test validations
  #----------------
  #validates_presence_of :category
  def test_should_not_be_valid_without_category
    @valid_category.category = nil
    assert !@valid_category.valid?
  end

  #  validates_uniqueness_of :category, :scope => :parent_id
  def test_new_category_should_be_valid_if_category_is_unique
    @new_category = @valid_category.clone
    @new_category.category = "unique"
    assert @new_category.valid?
  end

  def test_new_category_should_valid_if_parent_id_is_unique
    @new_category = @valid_category.clone
    @new_category.parent_id = 314159
    assert @new_category.valid?
  end

  def test_new_category_should_not_be_valid_if_duplicate_of_another_category
    @new_category = Category.new(
      :category => @valid_category.category, :parent_id => @valid_category.parent_id)
    assert !@new_category.valid?
  end
  
  #errors.add_to_base "Category cannot be a child of itself" if self.id == self.parent_id
  def test_should_not_be_valid_if_the_parent_is_itself
    @new_category = @valid_category.clone
    @new_category.parent_id = @new_category.id
    assert !@new_category.valid?
	end
  
  #test acts_as_tree
  #-----------------
  def test_parent_should_know_which_children_belong_to_it
    assert_equal([@valid_category.id], @valid_category.children.collect {|c| c.parent_id})
  end

  def test_child_should_know_who_its_parent_is
    @child_category = categories(:child_with_products)
    assert_equal(@valid_category.id, @child_category.parent.id)
  end

  #before_destroy
  #--------------
 	#errors.add_to_base "This catagory is a parent. Cannot delete." unless @check.nil?
  #errors.add_to_base "This category is referenced. Cannot delete." unless @check_relation.nil?
  def test_should_not_be_destroyed_if_parent
    assert_no_difference 'Category.count' do
      @valid_root_with_children_but_no_products.destroy
    end
  end
  
	def test_should_not_be_destroyed_if_referenced
    assert_no_difference 'Category.count' do
      @valid_child_with_products.destroy
    end
	end

	def test_should_not_be_destroyed_if_parent_and_referenced
    assert_no_difference 'Category.count' do
      @valid_category.destroy
    end
  end
	
	def test_should_be_destroyed_if_not_parent_and_not_referenced
    assert_difference 'Category.count', -1 do
      @valid_child_with_no_products.destroy
    end
  end
end
