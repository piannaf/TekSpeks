class AttrTypesController < ApplicationController
  layout 'application'

  # GET /attr_types
  # GET /attr_types.xml
  def index
    @attr_types = AttrType.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @attr_types }
    end
  end

  # GET /attr_types/1
  # GET /attr_types/1.xml
  def show
    @attr_type = AttrType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @attr_type }
    end
  end

  # GET /attr_types/new
  # GET /attr_types/new.xml
  def new
    @attr_type = AttrType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @attr_type }
    end
  end

  # GET /attr_types/1/edit
  def edit
    @attr_type = AttrType.find(params[:id])
  end
  
  # POST /attr_types
  # POST /attr_types.xml
  def create
    @attr_type = AttrType.new(params[:attr_type])

    respond_to do |format|
      if @attr_type.save
        flash[:notice] = 'AttrType was successfully created.'
        format.html { redirect_to(@attr_type) }
        format.xml  { render :xml => @attr_type, :status => :created, :location => @attr_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @attr_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /attr_types/1
  # PUT /attr_types/1.xml
  def update
    @attr_type = AttrType.find(params[:id])

    respond_to do |format|
      if @attr_type.update_attributes(params[:attr_type])
        flash[:notice] = 'AttrType was successfully updated.'
        format.html { redirect_to(@attr_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @attr_type.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /attr_types/1/delete
  def delete
    @attr_type = AttrType.find( params[:id] )
    respond_to do |format|
        format.html # delete.html.erb
    end
  end

  # DELETE /attr_types/1
  # DELETE /attr_types/1.xml
  def destroy
    @attr_type = AttrType.find(params[:id])
    redirect_to(@attr_type) and return if params[:cancel]

    respond_to do |format|
    	if @attr_type.destroy
    		flash[:notice] = 'Type was successfully destroyed.'
      	format.html { redirect_to(attr_types_url) }
      	format.xml  { head :ok }
    	else
    		flash[:notice] = 'Type was NOT destroyed.'
    		format.html { render :action => "delete"}
    		format.xml  { render :xml => @attr_type.errors, :status => :unprocessable_entity }
  		end
    end
  end
end
