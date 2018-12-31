require_relative '../Rule/rule'
require_relative '../Exception/validation_error'

class Builder
  attr_accessor :target_class, :rules, :parameters

  def initialize(target_class, rules)
    @target_class = target_class
    @rules = rules
    @parameters = target_class.attributes
  end

  def build
    validate_rules
    target_class.new(*parameter_values)
  end

  def parameter_values
    parameters.map do |parameter|
      send(parameter)
    end
  end

  def validate_rules
    rules.each do |rule|
      raise ValidationError, rule unless rule.satisfies?(self)
    end
  end
end
