class Rule
  attr_accessor :rule

  def initialize(&block)
    self.rule = Proc.new(&block)
  end

  def satisfies?(object)
    object.instance_eval(rule)
  end
end