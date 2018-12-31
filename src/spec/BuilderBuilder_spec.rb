require 'rspec'
require_relative '../lib/Rule/rule'
require_relative '../lib/Builder/builder.rb'
require_relative '../lib/Builder/builder_builder.rb'
require_relative '../../src/lib/Exception/validation_error'
require_relative '../lib/Object/object'

describe 'BuilderBuilder spec' do
  class Foo
    attr_reader :foo, :bar

    def initialize(foo, bar)
      @foo = foo
      @bar = bar
    end
  end

  rule = Rule.new do
    !foo.nil? && !bar.nil?
  end

  it 'Trying to build without setting values should raise validation error' do
    builderBuilder = BuilderBuilder.new(Foo)
    builderBuilder.add_rule do
      !foo.nil?
    end

    builder = builderBuilder.build

    expect do
      builder.build
    end.to raise_exception(ValidationError)
  end

  it 'Trying to build with foo > 3 and bar not nil' do
    builderBuilder = BuilderBuilder.new(Foo)
    builderBuilder.add_rule do
      foo > 3
    end

    builderBuilder.add_rule do
      !foo.nil?
    end

    builder = builderBuilder.build
    builder.foo = 42
    builder.bar = 'bar'

    expect(builder.foo).to eq(42)
    expect(builder.bar).to eq('bar')

    a = builder.build
    expect(a.foo).to eq(42)
  end
end