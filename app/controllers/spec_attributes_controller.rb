class SpecAttributesController < ApplicationController
  layout 'application'

  # GET /spec_attributes
  # GET /spec_attributes.xml
  def index
    @spec_attributes = SpecAttribute.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @spec_attributes }
    end
  end

  # GET /spec_attributes/1
  # GET /spec_attributes/1.xml
  def show
    @spec_attribute = SpecAttribute.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @spec_attribute }
    end
  end

  # GET /spec_attributes/new
  # GET /spec_attributes/new.xml
  def new
    @spec_attribute = SpecAttribute.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @spec_attribute }
    end
  end

  # GET /spec_attributes/1/edit
  def edit
    @spec_attribute = SpecAttribute.find(params[:id])
  end

  # POST /spec_attributes
  # POST /spec_attributes.xml
  def create
    @spec_attribute = SpecAttribute.new(params[:spec_attribute])

    respond_to do |format|
      if @spec_attribute.save
        flash[:notice] = 'SpecAttribute was successfully created.'
        format.html { redirect_to(@spec_attribute) }
        format.xml  { render :xml => @spec_attribute, :status => :created, :location => @spec_attribute }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @spec_attribute.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /spec_attributes/1
  # PUT /spec_attributes/1.xml
  def update
    @spec_attribute = SpecAttribute.find(params[:id])

    respond_to do |format|
      if @spec_attribute.update_attributes(params[:spec_attribute])
        flash[:notice] = 'SpecAttribute was successfully updated.'
        format.html { redirect_to(@spec_attribute) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @spec_attribute.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /spec_attributes/1/delete
  def delete
    @spec_attribute = SpecAttribute.find( params[:id] )
    respond_to do |format|
        format.html # delete.html.erb
    end
  end

  # DELETE /spec_attributes/1
  # DELETE /spec_attributes/1.xml
  def destroy
    @spec_attribute = SpecAttribute.find(params[:id])
    redirect_to(@spec_attribute) and return if params[:cancel]

    respond_to do |format|
    	if @spec_attribute.destroy
    		flash[:notice] = 'Attribute was successfully destroyed.'
      	format.html { redirect_to(spec_attributes_url) }
      	format.xml  { head :ok }
    	else
    		flash[:notice] = 'Attribute was NOT destroyed.'
    		format.html { render :action => "delete"}
    		format.xml  { render :xml => @spec_attribute.errors, :status => :unprocessable_entity }
  		end
    end
  end
end
