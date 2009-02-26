class ExpressionsController < ApplicationController

  # Needlessly duplicated from works_controller. Should
  # be in application.rb but I had some weird problem getting
  # that working right so I'll let it ride
  def edit_in_place
    @expression = Expression.find(params[:id])
    @expression.send "#{params[:field]}=", params[:value]
    @expression.save
    render :text => params[:value]
  end

  # Used for in_place_collection_editor, waiting to be cleaned
  # up and moved to some proper home where it will be used.
  def set_expression_reifications
    e = Expression.find(params[:id])
    work_id = params[:value]
    relation = params[:relation] || '' # TODO Carry over existing relation
    #render :text => "Setting up reification with work #{work_id}"
    # TODO Make sure this is all properly restful.
    # I'm going to ignore many-to-many relations here for now
    # and remove the existing work-to-expression relation,
    # just rudely dropping it, before adding a new one.
    # TODO Handle many-to-many relations properly.  One should be 
    # able to add a new relation and delete an existing one
    # indepedently and RESTFULly.
    e.reifications = []
    r = Reification.new(:expression_id => e.id, :work_id => work_id, :relation => relation)
    e.reifications << r
    render :text => Work.find(work_id).anchor_text
  end

  # GET /expressions
  # GET /expressions.xml
  def index
    @expressions = Expression.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expressions }
    end
  end

  # GET /expressions/1
  # GET /expressions/1.xml
  def show
    @expression = Expression.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expression }
      format.rdf  # show.rdf.builder
    end
  end

  # GET /expressions/new
  # GET /expressions/new.xml
  def new
    @expression = Expression.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expression }
    end
  end

  # GET /expressions/1/edit
  def edit
    @expression = Expression.find(params[:id])
  end

  # POST /expressions
  # POST /expressions.xml
  def create
    realizer_name = params[:name]
    realizer_type = params[:entity_type]

    @expression = Expression.new(params[:expression])
    @realizer = realizer_type._as_class.find_or_create_by_name(realizer_name)
    @reification = Reification.new(:work_id => params[:work_id], :expression_id => @expression.id, :relation => params[:relation])

    respond_to do |format|
      if @expression.save
        @realizer.save
        @expression.realizers << @realizer
	Work.find(params[:work_id]).reifications << @reification
	
        flash[:notice] = 'Expression was successfully created.'
        format.html { redirect_to(@expression) }
        format.xml  { render :xml => @expression, :status => :created, :location => @expression }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expression.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expressions/1
  # PUT /expressions/1.xml
  def update
    @expression = Expression.find(params[:id])

    respond_to do |format|
      if @expression.update_attributes(params[:expression])
        flash[:notice] = 'Expression was successfully updated.'
        format.html { redirect_to(@expression) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expression.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expressions/1
  # DELETE /expressions/1.xml
  def destroy
    @expression = Expression.find(params[:id])
    # TODO: Move into the expressions model as :after_destroy callback?
    # TODO: Also need to remove Expression-Manifestation connection
    @expression.reifications.each do |r|
      Work.find(r.work_id).reifications.delete(r)
    end 
    @expression.destroy

    respond_to do |format|
      format.html { redirect_to(expressions_url) }
      format.xml  { head :ok }
    end
  end

end
