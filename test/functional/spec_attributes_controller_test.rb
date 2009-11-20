require 'test_helper'
require 'shoulda'

class SpecAttributesControllerTest < ActionController::TestCase
	
	context "on GET to :index" do
		setup { get :index }
		
		should_assign_to :spec_attributes
		should_respond_with :success
		should_render_template :index
		should_not_set_the_flash
	end
	
	context "on GET to :show" do
	  setup {
	  	SpecAttribute.stubs(:find).returns(SpecAttribute.new)
	  	get :show
	 }
	
		should_assign_to :spec_attribute
	  should_respond_with :success
	  should_render_template :show
	  should_not_set_the_flash
	end

  context "on GET to :new" do
		setup { get :new }
		
		should_assign_to :spec_attribute
		should_respond_with :success
		should_render_template :new
		should_not_set_the_flash
	end
	
	context "on POST to :create" do
		setup {
			post :create, :spec_attribute => {}
		}
		
		should_assign_to :spec_attribute
		
		context "is success" do
			setup {
				SpecAttribute.any_instance.stubs(:valid?).returns(true)
			  post :create
			}
			
			should_redirect_to "spec_attribute_path(@spec_attribute)"
			should_set_the_flash_to(/created/i)
		end
		
		context "is failure" do
			setup {
				SpecAttribute.any_instance.stubs(:valid?).returns(false)
			  post :create
			}

			should_respond_with :success
			should_render_template :new
			should_not_set_the_flash
		end
	end

	context "on GET to :edit" do
		setup {
			SpecAttribute.stubs(:find).returns(SpecAttribute.new)
			get :edit
		}
		
		should_assign_to :spec_attribute
		should_respond_with :success
		should_render_template :edit
		should_not_set_the_flash
	end

	context "on PUT to :update" do
		setup {
			SpecAttribute.stubs(:find).returns(SpecAttribute.new)
			put :update 
		}
		
		should_assign_to :spec_attribute
		
		context "is success" do
			setup {
				SpecAttribute.any_instance.stubs(:valid?).returns(true)
				put :update
			}
		
			should_redirect_to "spec_attribute_path(@spec_attribute)"
			should_set_the_flash_to(/updated/i)
		end
		
		context "is failure" do
			setup {
				SpecAttribute.any_instance.stubs(:valid?).returns(false)
			  put :update
			}

			should_respond_with :success
			should_render_template :edit
			should_not_set_the_flash
		end
	end

	context "on GET to :delete" do
		setup {
			SpecAttribute.stubs(:find).returns(SpecAttribute.new)
			get :delete
		}
		
		should_assign_to :spec_attribute
		should_respond_with :success
		should_render_template :delete
		should_not_set_the_flash
	end
	
	context "on DELETE to :destroy" do
		setup {
			SpecAttribute.stubs(:find).returns(SpecAttribute.new)
			delete :destroy
		}
		
		should_assign_to :spec_attribute
		
		context "is cancelled" do
			setup {
				SpecAttribute.any_instance.stubs(:cancel).returns(true)
				delete :destroy
			}
			
			should_redirect_to "spec_attribute_path(@spec_attribute)"
		end
		
		context "is success" do
			setup {
				SpecAttribute.any_instance.stubs(:destroy).returns(true)
				delete :destroy
			}
			
			should_redirect_to "spec_attributes_url"
			should_set_the_flash_to(/destroyed/i)
		end
		
		context "is failure" do
			
			setup {
				SpecAttribute.any_instance.stubs(:destroy).returns(false)
				delete :destroy
			}
			should_respond_with :success
			should_render_template :delete
			should_set_the_flash_to(/NOT/i)
		end
	end
end
