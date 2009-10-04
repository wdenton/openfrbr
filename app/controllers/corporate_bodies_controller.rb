class CorporateBodiesController < ApplicationController

  before_filter :require_user, :only => [:create, :new, :edit, :edit_in_place, :update, :destroy]

  # GET /corporate_bodies
  # GET /corporate_bodies.xml
  def index
    @corporate_bodies = CorporateBody.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @corporate_bodies }
    end
  end

  # GET /corporate_bodies/1
  # GET /corporate_bodies/1.xml
  def show
    @corporate_body = CorporateBody.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @corporate_body }
    end
  end

  # GET /corporate_bodies/new
  # GET /corporate_bodies/new.xml
  def new
    @corporate_body = CorporateBody.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @corporate_body }
    end
  end

  # GET /corporate_bodies/1/edit
  def edit
    @corporate_body = CorporateBody.find(params[:id])
  end

  # POST /corporate_bodies
  # POST /corporate_bodies.xml
  def create
    @corporate_body = CorporateBody.new(params[:corporate_body])

    respond_to do |format|
      if @corporate_body.save
        flash[:notice] = 'CorporateBody was successfully created.'
        format.html { redirect_to(@corporate_body) }
        format.xml  { render :xml => @corporate_body, :status => :created, :location => @corporate_body }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @corporate_body.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /corporate_bodies/1
  # PUT /corporate_bodies/1.xml
  def update
    @corporate_body = CorporateBody.find(params[:id])

    respond_to do |format|
      if @corporate_body.update_attributes(params[:corporate_body])
        flash[:notice] = 'CorporateBody was successfully updated.'
        format.html { redirect_to(@corporate_body) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @corporate_body.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /corporate_bodies/1
  # DELETE /corporate_bodies/1.xml
  def destroy
    @corporate_body = CorporateBody.find(params[:id])
    @corporate_body.destroy

    respond_to do |format|
      format.html { redirect_to(corporate_bodies_url) }
      format.xml  { head :ok }
    end
  end
end
