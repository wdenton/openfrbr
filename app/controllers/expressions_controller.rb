class ExpressionsController < ApplicationController
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
    @expression = Expression.new(params[:expression])

    respond_to do |format|
      if @expression.save
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
    @expression.destroy

    respond_to do |format|
      format.html { redirect_to(expressions_url) }
      format.xml  { head :ok }
    end
  end
end
