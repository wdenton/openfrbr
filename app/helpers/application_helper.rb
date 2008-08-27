module ApplicationHelper

  def subject_name(subject)
    # The attribute we use to refer to a subject depends on
    # what kind of entity it is.  
    if %w[Work Expression Manifestation Item].include?(subject.class.to_s)
      return subject.title
    elsif %w[Person Family CorporateBody].include?(subject.class.to_s)
      return subject.name
    elsif %w[Concept Event FrbrObject Place].include?(subject.class.to_s)
      return subject.term
    end
  end

end
