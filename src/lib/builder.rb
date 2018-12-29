class Builder
  attr_accessor :target_class, :rules, :parameters

  def initialize(klass, rules)
    self.target_class = klass
    self.rules = rules
  end

  def build
    if rules.any? do |rule|
      !rule.satisfies?(self)
    end
      raise ArgumentError 'Didn\'t meet the criteria'
    end

    target_class.new(*parameters)
  end
end