class BuilderBuilder
  attr_accessor :target_class, :rules

  def initialize(target_class, rules = [])
    @target_class = target_class
    @rules = rules
  end

  def build(validate = true)
    validate_contradictions if validate

    builder = Builder.new(target_class, rules)
    target_class.attributes.each do |attribute|
      builder.class.attr_accessor attribute
    end

    builder
  end

  def validate_contradictions
    rules.each do |rule|
      this = copy
      other_rules = rules.reject do |other_rule|
        other_rule.equal?(rule)
      end

      next unless other_rules.any? do |other_rule|
        rule.contradiction?(other_rule, this)
      end
      raise ContradictionError
    end
  end

  def add_rule(&block)
    rules.append(Rule.new(&block))
  end

  def copy
    BuilderBuilder.new(target_class, rules)
  end
end
