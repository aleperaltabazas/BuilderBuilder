class Builder
  attr_accessor :klass, :rules, :parameters

  def initialize(klass, rules)
    self.klass = klass
    self.rules = rules
  end

  def build
    if rules.any? do |rule|
      rule.satisfies?(self)
    end
      raise ArgumentError 'Didn\'t meet the criteria'
    end

    klass.new(*parameters)
  end
end