class ProductsController < ApplicationController

  layout 'application'

  before_filter :initialize_check_boxes, :only => [:create, :update]

  # GET /products
  # GET /products.xml
  def index
    @products = Product.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new
    @descriptions = Specification.find_all_by_unit_id(nil)
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @descriptions = Specification.find_all_by_unit_id(nil)
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        flash[:notice] = 'Product was successfully created.'
        format.html { redirect_to(@product) }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Product was successfully updated.'
        format.html { redirect_to(@product) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /products/1/delete
  def delete
    @product = Product.find( params[:id] )
    respond_to do |format|
        format.html # delete.html.erb
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    redirect_to(@product) and return if params[:cancel]

    respond_to do |format|
    	if @product.destroy
    		flash[:notice] = 'Product was successfully destroyed.'
      	format.html { redirect_to(products_url) }
      	format.xml  { head :ok }
    	else
    		flash[:notice] = 'Product was NOT destroyed.'
    		format.html { render :action => "delete"}
    		format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
  		end
    end
  end

  private
  
  def initialize_check_boxes
    params[:product][:category_ids] ||= []
    params[:product][:specification_ids] ||= []
  end
end
