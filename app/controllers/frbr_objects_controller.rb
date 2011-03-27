class FrbrObjectsController < ApplicationController

  before_filter :require_user, :only => [:create, :new, :edit, :edit_in_place, :update, :destroy]

  # GET /frbr_objects
  # GET /frbr_objects.xml
  def index
    @frbr_objects = FrbrObject.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @frbr_objects }
    end
  end

  # GET /frbr_objects/1
  # GET /frbr_objects/1.xml
  def show
    @frbr_object = FrbrObject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @frbr_object }
    end
  end

  # GET /frbr_objects/new
  # GET /frbr_objects/new.xml
  def new
    @frbr_object = FrbrObject.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @frbr_object }
    end
  end

  # GET /frbr_objects/1/edit
  def edit
    @frbr_object = FrbrObject.find(params[:id])
  end

  # POST /frbr_objects
  # POST /frbr_objects.xml
  def create
    @frbr_object = FrbrObject.new(params[:frbr_object])

    respond_to do |format|
      if @frbr_object.save
        flash[:notice] = 'FrbrObject was successfully created.'
        format.html { redirect_to(@frbr_object) }
        format.xml  { render :xml => @frbr_object, :status => :created, :location => @frbr_object }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @frbr_object.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /frbr_objects/1
  # PUT /frbr_objects/1.xml
  def update
    @frbr_object = FrbrObject.find(params[:id])

    respond_to do |format|
      if @frbr_object.update_attributes(params[:frbr_object])
        flash[:notice] = 'FrbrObject was successfully updated.'
        format.html { redirect_to(@frbr_object) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @frbr_object.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /frbr_objects/1
  # DELETE /frbr_objects/1.xml
  def destroy
    @frbr_object = FrbrObject.find(params[:id])
    @frbr_object.destroy

    respond_to do |format|
      format.html { redirect_to(frbr_objects_url) }
      format.xml  { head :ok }
    end
  end
end
