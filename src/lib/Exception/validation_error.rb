class ValidationError < Exception
  attr_reader :rule

  def initialize(rule)
    @rule = rule
    msg = "Object did not pass rule #{rule.rule.to_s}"
    super(msg)
  end
end