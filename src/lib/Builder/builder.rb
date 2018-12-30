require_relative '../Rule/rule'
require_relative '../Rule/rule'

class Builder
  attr_accessor :target_class, :rules

  def initialize(target_class, rules)
    self.target_class = target_class
    self.rules = rules
  end

  def build
    rules.each do |rule|
      raise ValidationError(rule) unless rule.satisfies?(self)
    end

    target_class.new(*attributes)
  end
end
