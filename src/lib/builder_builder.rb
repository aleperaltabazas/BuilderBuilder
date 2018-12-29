class BuilderBuilder
  attr_accessor :klass, :rules, :parameters

  def initialize(klass)
    self.klass = klass
  end

  def build
    builder = Builder.new(klass, rules)

    klass.attributes.each do |attribute|
      builder.define_singleton_method(attribute) do
        builder.class.attr_accessor(attribute)
      end
    end
  end
end
