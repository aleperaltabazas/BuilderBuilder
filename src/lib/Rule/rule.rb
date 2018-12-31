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
    false
  end
end