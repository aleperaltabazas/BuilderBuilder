require_relative 'rule'

class Builder
  attr_accessor :target_class, :rules

  def initialize(target_class, rules)
    self.target_class = target_class
    self.rules = rules
  end

  def build
    if rules.any? do |rule|
      !rule.satisfies?(self)
    end
      raise ArgumentError 'Didn\'t meet the criteria'
    end

    target_class.new(*attributes)
  end
end