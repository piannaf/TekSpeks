require 'test_helper'
require 'shoulda'

class AttrTypesControllerTest < ActionController::TestCase
	
	context "on GET to :index" do
		setup { get :index }
		
		should_assign_to :attr_types
		should_respond_with :success
		should_render_template :index
		should_not_set_the_flash
	end
	
	context "on GET to :show" do
	  setup {
	  	AttrType.stubs(:find).returns(AttrType.new)
	  	get :show
	 }
	
		should_assign_to :attr_type
	  should_respond_with :success
	  should_render_template :show
	  should_not_set_the_flash
	end

  context "on GET to :new" do
		setup { get :new }
		
		should_assign_to :attr_type
		should_respond_with :success
		should_render_template :new
		should_not_set_the_flash
	end
	
	context "on POST to :create" do
		setup {
			post :create, :attr_type => {}
		}
		
		should_assign_to :attr_type
		
		context "is success" do
			setup {
				AttrType.any_instance.stubs(:valid?).returns(true)
			  post :create
			}
			
			should_redirect_to "attr_type_path(@attr_type)"
			should_set_the_flash_to(/created/i)
		end
		
		context "is failure" do
			setup {
				AttrType.any_instance.stubs(:valid?).returns(false)
			  post :create
			}

			should_respond_with :success
			should_render_template :new
			should_not_set_the_flash
		end
	end

	context "on GET to :edit" do
		setup {
			AttrType.stubs(:find).returns(AttrType.new)
			get :edit
		}
		
		should_assign_to :attr_type
		should_respond_with :success
		should_render_template :edit
		should_not_set_the_flash
	end

	context "on PUT to :update" do
		setup {
			AttrType.stubs(:find).returns(AttrType.new)
			put :update 
		}
		
		should_assign_to :attr_type
		
		context "is success" do
			setup {
				AttrType.any_instance.stubs(:valid?).returns(true)
				put :update
			}
		
			should_redirect_to "attr_type_path(@attr_type)"
			should_set_the_flash_to(/updated/i)
		end
		
		context "is failure" do
			setup {
				AttrType.any_instance.stubs(:valid?).returns(false)
			  put :update
			}

			should_respond_with :success
			should_render_template :edit
			should_not_set_the_flash
		end
	end

	context "on GET to :delete" do
		setup {
			AttrType.stubs(:find).returns(AttrType.new)
			get :delete
		}
		
		should_assign_to :attr_type
		should_respond_with :success
		should_render_template :delete
		should_not_set_the_flash
	end
	
	context "on DELETE to :destroy" do
		setup {
			AttrType.stubs(:find).returns(AttrType.new)
			delete :destroy
		}
		
		should_assign_to :attr_type
		
		context "is cancelled" do
			setup {
				AttrType.any_instance.stubs(:cancel).returns(true)
				delete :destroy
			}
			
			should_redirect_to "attr_type_path(@attr_type)"
		end
		
		context "is success" do
			setup {
				AttrType.any_instance.stubs(:destroy).returns(true)
				delete :destroy
			}
			
			should_redirect_to "attr_types_url"
			should_set_the_flash_to(/destroyed/i)
		end
		
		context "is failure" do
			
			setup {
				AttrType.any_instance.stubs(:destroy).returns(false)
				delete :destroy
			}
			should_respond_with :success
			should_render_template :delete
			should_set_the_flash_to(/NOT/i)
		end
	end
end
