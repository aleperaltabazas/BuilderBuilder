class ContextProvider
  attr_accessor :object, :rule

  def initialize(object)
    @object = object
  end

  def evaluate(rule)
    @rule = rule
  end
end
