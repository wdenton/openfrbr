class WorksController < ApplicationController

  # in_place_edit_for :work, :title

  def edit_in_place
    @work = Work.find(params[:id])
    @work.send "#{params[:field]}=", params[:value]
    @work.save
    render :text => params[:value]
  end

  def list_works_by_anchor_text
    @works = Works.all
    respond_to do |format|
      format.json {render :json => @works.map{|w| [w.id, w.anchor_text]}}  
    end
  end
  
  # GET /works
  # GET /works.xml
  def index
    @works = Work.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @works }
    end
  end

  # GET /works/1
  # GET /works/1.xml
  def show
    @work = Work.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @work }
    end
  end

  # GET /works/new
  # GET /works/new.xml
  def new
    @work = Work.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @work }
    end
  end

  # GET /works/1/edit
  def edit
    @work = Work.find(params[:id])
  end

  # POST /works
  # POST /works.xml
  def create

    creator_name = params[:name]
    creator_type = params[:entity_type]

    if creator_name.empty?
      flash[:notice] = "You must enter a creator."
      redirect_to :action => 'new' and return
    end

    @work = Work.new(params[:work])
    @creator = creator_type._as_class.find_or_create_by_name(creator_name)

    respond_to do |format|
      if @work.save
        # TODO Better error-checking here
        @creator.save
        @work.creators << @creator 
        @work.save
        flash[:notice] = 'Work was successfully created.'
        format.html { redirect_to(@work) }
        format.xml  { render :xml => @work, :status => :created, :location => @work }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @work.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /works/1
  # PUT /works/1.xml
  def update
    @work = Work.find(params[:id])

    respond_to do |format|
      if @work.update_attributes(params[:work])
        flash[:notice] = 'Work was successfully updated.'
        format.html { redirect_to(@work) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @work.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.xml
  def destroy
    @work = Work.find(params[:id])
    @work.destroy

    respond_to do |format|
      format.html { redirect_to(works_url) }
      format.xml  { head :ok }
    end
  end

  def remove_creator(work_id, creator_type, creator_id)
    @work = Work.find(work_id)
    if @work.creators.delete(creator_type.find(creator_id))
      flash[:notice] = 'Creator removed.'
      format.html { redirect_to(@work) }
      format.xml  { head :ok }
    else
      flash[:notice] = 'Error: could not remove creator.'
      format.html { redirect_to(@work) }
      format.xml  { render :xml => "Error", :status => :unprocessable_entity }
    end
  end    

end
