class BuilderBuilder
  attr_accessor :target_class, :rules, :parameters

  def initialize(target_class)
    @target_class = target_class
    @rules = []
  end

  def build
    builder = Builder.new(target_class, rules)
    target_class.attributes.each do |attribute|
      builder.class.attr_accessor attribute
    end

    builder
  end

  def add_rule(&block)
    rules.append(Rule.new(&block))
  end
end
