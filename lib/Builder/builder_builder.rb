require 'sourcify'
require_relative '../Rule/rule_map'

class BuilderBuilder
  attr_accessor :target_class, :rules, :map

  def initialize(target_class, rules = [])
    @target_class = target_class
    @rules = rules
    @map = RuleMap.new
  end

  def build(validate = true, skip_contingency = false)
    builder = Builder.new(target_class, rules)
    target_class.attributes.each do |attribute|
      builder.class.attr_accessor attribute
    end

    begin
      validate_contradictions if validate
    rescue Contingency => c
      raise c unless skip_contingency
    end

    builder
  end

  def validate_contradictions
    rules.each do |rule|
      other_rules = rules.reject do |other_rule|
        other_rule.equal?(rule)
      end

      next unless other_rules.any? do |other_rule|
        rule.contradictory?(other_rule)
      end

      raise ContradictionError
    end
  end

  def add_rule(&block)
    rules.append(Rule.new(map, &block))
  end
end
