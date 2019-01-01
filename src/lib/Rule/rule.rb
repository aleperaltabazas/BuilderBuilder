require_relative '../Contradiction/context_provider'

class Rule
  attr_accessor :rule

  def initialize(&block)
    self.rule = Proc.new(&block)
  end

  def satisfies?(object)
    object.instance_eval(&rule)
  end

  def contradiction?(other_rule, object)
    contrary?(other_rule, object) && !other_rule.satisfies?(object)
  end

  def contrary?(other_rule, object)
    methods = ContextProvider.new(object).evaluate(self)
    other_methods = ContextProvider.new(object).evaluate(other_rule)
    puts methods.to_s
    puts other_methods.to_s

    methods.equal? other_methods
  end
end
