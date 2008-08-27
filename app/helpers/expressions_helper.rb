module ExpressionsHelper

  # Make it easy to find the work that goes with an expression.
  # Since this is a has_many :through relation, there's an
  # extra step involved, but this makes it easy.
  def work_for_expression(expression)
    return Work.find(expression.reifications[0].work_id)
  end

end
