class ValidationError < Exception
  def initialize(rule)
    msg = "Object did not pass rule #{rule.rule.to_s}"
    super(msg)
  end
end