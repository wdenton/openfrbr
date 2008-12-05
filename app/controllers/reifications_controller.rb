class ReificationsController < ApplicationController

  # POST /reifications/1
  # POST /reifications/1.xml
  def update
    @reification=Reification.find(params[:id])
    @reification.work_id=params[:work_id]
    @reification.expression_id=params[:expression_id]
    @reification.relation = params[:relation] # TODO Unhide in form

    respond_to do |format|
      if @reification.save
        flash[:notice] = 'Reification was successfully updated.'
        format.html { redirect_to(Expression.find(@reification.expression_id)) }
        format.xml  { render :xml => @reification, :status => :created, :location => @reification }
      else
        flash[:notice] = 'Could not update reification.'
        format.html { redirect_to(Expression.find(@reification.expression_id)) }
        format.xml  { render :xml => @reification.errors, :status => :unprocessable_entity }
      end
    end
  end

end
