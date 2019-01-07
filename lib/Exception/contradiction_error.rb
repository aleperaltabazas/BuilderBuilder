class ContradictionError < Exception
  def initialize
    super('One or more rules were evaluated as contradictory')
  end
end