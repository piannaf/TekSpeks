require 'test_helper'
require 'shoulda'

class SpecificationsControllerTest < ActionController::TestCase
	
	context "on GET to :index" do
		setup { get :index }
		
		should_assign_to :specifications
		should_respond_with :success
		should_render_template :index
		should_not_set_the_flash
	end
	
	context "on GET to :show" do
	  setup {
	  	Specification.stubs(:find).returns(Specification.new)
	  	get :show
	 }
	
		should_assign_to :specification
	  should_respond_with :success
	  should_render_template :show
	  should_not_set_the_flash
	end

  context "on GET to :new" do
		setup { get :new }
		
		should_assign_to :specification
		should_respond_with :success
		should_render_template :new
		should_not_set_the_flash
	end
	
	context "on POST to :create" do
		setup {
			post :create, :specification => {}
		}
		
		should_assign_to :specification
		
		context "is success" do
			setup {
				Specification.any_instance.stubs(:valid?).returns(true)
			  post :create
			}
			
			should_redirect_to "specification_path(@specification)"
			should_set_the_flash_to(/created/i)
		end
		
		context "is failure" do
			setup {
				Specification.any_instance.stubs(:valid?).returns(false)
			  post :create
			}

			should_respond_with :success
			should_render_template :new
			should_not_set_the_flash
		end
	end

	context "on GET to :edit" do
		setup {
			Specification.stubs(:find).returns(Specification.new)
			get :edit
		}
		
		should_assign_to :specification
		should_respond_with :success
		should_render_template :edit
		should_not_set_the_flash
	end

	context "on PUT to :update" do
		setup {
			Specification.stubs(:find).returns(Specification.new)
			put :update 
		}
		
		should_assign_to :specification
		
		context "is success" do
			setup {
				Specification.any_instance.stubs(:valid?).returns(true)
				put :update
			}
		
			should_redirect_to "specification_path(@specification)"
			should_set_the_flash_to(/updated/i)
		end
		
		context "is failure" do
			setup {
				Specification.any_instance.stubs(:valid?).returns(false)
			  put :update
			}

			should_respond_with :success
			should_render_template :edit
			should_not_set_the_flash
		end
	end

	context "on GET to :delete" do
		setup {
			Specification.stubs(:find).returns(Specification.new)
			get :delete
		}
		
		should_assign_to :specification
		should_respond_with :success
		should_render_template :delete
		should_not_set_the_flash
	end
	
	context "on DELETE to :destroy" do
		setup {
			Specification.stubs(:find).returns(Specification.new)
			delete :destroy
		}
		
		should_assign_to :specification
		
		context "is cancelled" do
			setup {
				Specification.any_instance.stubs(:cancel).returns(true)
				delete :destroy
			}
			
			should_redirect_to "specification_path(@specification)"
		end
		
		context "is success" do
			setup {
				Specification.any_instance.stubs(:destroy).returns(true)
				delete :destroy
			}
			
			should_redirect_to "specifications_url"
			should_set_the_flash_to(/destroyed/i)
		end
		
		context "is failure" do
			
			setup {
				Specification.any_instance.stubs(:destroy).returns(false)
				delete :destroy
			}
			should_respond_with :success
			should_render_template :delete
			should_set_the_flash_to(/NOT/i)
		end
	end
end
