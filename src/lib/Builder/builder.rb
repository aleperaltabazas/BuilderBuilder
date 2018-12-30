require_relative '../Rule/rule'
require_relative '../Exception/validation_error'

class Builder
  attr_accessor :target_class, :rules

  def initialize(target_class, rules)
    self.target_class = target_class
    self.rules = rules
  end

  def build
    valid?
    target_class.new(*attributes)
  end

  def valid?
    rules.each do |rule|
      raise ValidationError.new(rule) unless rule.satisfies?(self)
    end
  end

end
