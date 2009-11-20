require 'test_helper'
require 'shoulda'

class ProductsControllerTest < ActionController::TestCase
	
	context "on GET to :index" do
		setup { get :index }
		
		should_assign_to :products
		should_respond_with :success
		should_render_template :index
		should_not_set_the_flash
	end
	
	context "on GET to :show" do
	  setup {
	  	Product.stubs(:find).returns(Product.new)
	  	get :show
	 }
	
		should_assign_to :product
	  should_respond_with :success
	  should_render_template :show
	  should_not_set_the_flash
	end

  context "on GET to :new" do
		setup { get :new }
		
		should_assign_to :product
		should_respond_with :success
		should_render_template :new
		should_not_set_the_flash
	end
	
	context "on POST to :create" do
		setup {
			post :create, :product => {}
		}
		
		should_assign_to :product
		
		context "is success" do
			setup {
				Product.any_instance.stubs(:valid?).returns(true)
			  post :create, :product => {}
			}
			
			should_redirect_to "product_path(@product)"
			should_set_the_flash_to(/created/i)
		end
		
		context "is failure" do
			setup {
				Product.any_instance.stubs(:valid?).returns(false)
			  post :create, :product => {}
			}

			should_respond_with :success
			should_render_template :new
			should_not_set_the_flash
		end
	end

	context "on GET to :edit" do
		setup {
			Product.stubs(:find).returns(Product.new)
			get :edit
		}
		
		should_assign_to :product
		should_respond_with :success
		should_render_template :edit
		should_not_set_the_flash
	end

	context "on PUT to :update" do
		setup {
			#category = stub_everything
			#Category.any_instance.stubs(:find).returns(category)
			Product.stubs(:find).returns(Product.new)
			put :update, :product => {}
		}
		
		should_assign_to :product
		
		context "is success" do
			setup {
				Product.any_instance.stubs(:valid?).returns(true)
				put :update, :product => {}
			}
		
			should_redirect_to "product_path(@product)"
			should_set_the_flash_to(/updated/i)
		end
		
		context "is failure" do
			setup {
				Product.any_instance.stubs(:valid?).returns(false)
			  put :update, :product => {}
			}

			should_respond_with :success
			should_render_template :edit
			should_not_set_the_flash
		end
	end

	context "on GET to :delete" do
		setup {
			Product.stubs(:find).returns(Product.new)
			get :delete
		}
		
		should_assign_to :product
		should_respond_with :success
		should_render_template :delete
		should_not_set_the_flash
	end
	
	context "on DELETE to :destroy" do
		setup {
			Product.stubs(:find).returns(Product.new)
			delete :destroy
		}
		
		should_assign_to :product
		
		context "is cancelled" do
			setup {
				Product.any_instance.stubs(:cancel).returns(true)
				delete :destroy
			}
			
			should_redirect_to "product_path(@product)"
		end
		
		context "is success" do
			setup {
				Product.any_instance.stubs(:destroy).returns(true)
				delete :destroy
			}
			
			should_redirect_to "products_url"
			should_set_the_flash_to(/destroyed/i)
		end
		
		context "is failure" do
			
			setup {
				Product.any_instance.stubs(:destroy).returns(false)
				delete :destroy
			}
			should_respond_with :success
			should_render_template :delete
			should_set_the_flash_to(/NOT/i)
		end
	end
end
