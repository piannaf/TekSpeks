class CategoriesController < ApplicationController
  layout 'application'

  # GET /categories
  # GET /categories.xml
  def index
    @categories = Category.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end
  
  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        format.html { redirect_to(@category) }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
        format.html { redirect_to(@category) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /categories/1/delete
  def delete
    @category = Category.find( params[:id] )
    respond_to do |format|
        format.html # delete.html.erb
    end
  end

  # DELETE /categorys/1
  # DELETE /categorys/1.xml
  def destroy
    @category = Category.find(params[:id])
    redirect_to(@category) and return if params[:cancel]

    respond_to do |format|
    	if @category.destroy
    		flash[:notice] = 'Category was successfully destroyed.'
      	format.html { redirect_to(categories_url) }
      	format.xml  { head :ok }
    	else
    		flash[:notice] = 'Category was NOT destroyed.'
    		format.html { render :action => "delete"}
    		format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
  		end
    end
  end
end
