class SubjectsController < ApplicationController
  def create
    @work = Work.find(params[:work_id])
    subject_term = params[:subject_term]
    subject_type = params[:subject_type]
    # TODO: Make a generic find_or_create_by_name (title, term)
    # in the various classes so that this can be done in one.
    if %w[Work Expression Manifestation Item].include?(subject_type)
      @work.subjects << subject_type._as_class.find_or_create_by_title(subject_term)
    elsif %w[Person Family CorporateBody].include?(subject_type)
      @work.subjects << subject_type._as_class.find_or_create_by_name(subject_term)
    elsif %w[Concept Event FrbrObject Place].include?(subject_type)
      @work.subjects << subject_type._as_class.find_or_create_by_term(subject_term)
    end

    respond_to do |format|
      format.html { redirect_to @work }
      format.js
    end
  end

  def destroy
    # TODO: Add destroy method that can be used with Ajax
    # to reverse the create method and disconnect a work and
    # a subject.
  end

end
