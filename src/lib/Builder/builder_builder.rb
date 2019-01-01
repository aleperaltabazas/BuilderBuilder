class BuilderBuilder
  attr_accessor :target_class, :rules

  def initialize(target_class, rules = [])
    @target_class = target_class
    @rules = rules
  end

  def build(validate = true)
    builder = Builder.new(target_class, rules)
    target_class.attributes.each do |attribute|
      builder.class.attr_accessor attribute
    end

    validate_contradictions(builder) if validate

    builder
  end

  def validate_contradictions(builder)
    rules.each do |rule|
      other_rules = rules.reject do |other_rule|
        other_rule.equal?(rule)
      end

      next unless other_rules.any? do |other_rule|
        rule.contradiction?(other_rule, builder)
      end
      raise ContradictionError
    end
  end

  def add_rule(&block)
    rules.append(Rule.new(&block))
  end
end
