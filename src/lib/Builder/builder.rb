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
    valid?
    target_class.new(*parameter_values)
  end

  def parameter_values
    parameters.map do |parameter|
      send(parameter)
    end
  end

  def valid?
    rules.each do |rule|
      raise ValidationError.new(rule) unless rule.satisfies?(self)
    end
  end
end
