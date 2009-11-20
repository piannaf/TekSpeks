require 'test_helper'
require 'shoulda'

class UnitsControllerTest < ActionController::TestCase
	
	context "on GET to :index" do
		setup { get :index }
		
		should_assign_to :units
		should_respond_with :success
		should_render_template :index
		should_not_set_the_flash
	end
	
	context "on GET to :show" do
	  setup {
	  	attr_type = AttrType.new
	  	unit = stub_everything(:name => 'name', :abbrev => 'abbrev', :system => 'system', :class => Unit)
	  	unit.stubs(:attr_type).returns(attr_type)
	  	Unit.stubs(:find).returns(unit)
	  	get :show
	 }
	
		should_assign_to :unit
	  should_respond_with :success
	  should_render_template :show
	  should_not_set_the_flash
	end

  context "on GET to :new" do
		setup { get :new }
		
		should_assign_to :unit
		should_respond_with :success
		should_render_template :new
		should_not_set_the_flash
	end
	
	context "on POST to :create" do
		setup {
			post :create, :unit => {}
		}
		
		should_assign_to :unit
		
		context "is success" do
			setup {
				Unit.any_instance.stubs(:valid?).returns(true)
			  post :create
			}
			
			should_redirect_to "unit_path(@unit)"
			should_set_the_flash_to(/created/i)
		end
		
		context "is failure" do
			setup {
				Unit.any_instance.stubs(:valid?).returns(false)
			  post :create
			}

			should_respond_with :success
			should_render_template :new
			should_not_set_the_flash
		end
	end

	context "on GET to :edit" do
		setup {
			Unit.stubs(:find).returns(Unit.new)
			get :edit
		}
		
		should_assign_to :unit
		should_respond_with :success
		should_render_template :edit
		should_not_set_the_flash
	end

	context "on PUT to :update" do
		setup {
			Unit.stubs(:find).returns(Unit.new)
			put :update 
		}
		
		should_assign_to :unit
		
		context "is success" do
			setup {
				Unit.any_instance.stubs(:valid?).returns(true)
				put :update
			}
		
			should_redirect_to "unit_path(@unit)"
			should_set_the_flash_to(/updated/i)
		end
		
		context "is failure" do
			setup {
				Unit.any_instance.stubs(:valid?).returns(false)
			  put :update
			}

			should_respond_with :success
			should_render_template :edit
			should_not_set_the_flash
		end
	end

	context "on GET to :delete" do
		setup {
	  	Unit.any_instance.stubs(:attr_type).returns(AttrType.new)
			Unit.any_instance.stubs(:name).returns('name')
			Unit.stubs(:find).returns(Unit.new)
			get :delete
		}
		
		should_assign_to :unit
		should_respond_with :success
		should_render_template :delete
		should_not_set_the_flash
	end
	
	context "on DELETE to :destroy" do
		setup {
	  	Unit.any_instance.stubs(:attr_type).returns(AttrType.new)
			Unit.any_instance.stubs(:name).returns('name')
			Unit.stubs(:find).returns(Unit.new)
			delete :destroy
		}
		
		should_assign_to :unit
		
		context "is cancelled" do
			setup {
				Unit.any_instance.stubs(:cancel).returns(true)
				delete :destroy
			}
			
			should_redirect_to "unit_path(@unit)"
		end
		
		context "is success" do
			setup {
				Unit.any_instance.stubs(:destroy).returns(true)
				delete :destroy
			}
			
			should_redirect_to "units_url"
			should_set_the_flash_to(/destroyed/i)
		end
		
		context "is failure" do
			
			setup {
				Unit.any_instance.stubs(:destroy).returns(false)
				delete :destroy
			}
			should_respond_with :success
			should_render_template :delete
			should_set_the_flash_to(/NOT/i)
		end
	end
end
