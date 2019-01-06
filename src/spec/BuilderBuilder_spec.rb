require 'rspec'
require_relative '../lib/Rule/rule'
require_relative '../lib/Builder/builder.rb'
require_relative '../lib/Builder/builder_builder.rb'
require_relative '../lib/Exception/validation_error'
require_relative '../lib/Exception/contradiction_error'
require_relative '../lib/Object/object'

describe 'BuilderBuilder spec' do
  class Foo
    attr_reader :foo, :bar

    def initialize(foo, bar)
      @foo = foo
      @bar = bar
    end
  end

  it 'Trying to build without setting values should raise validation error' do
    builder_builder = BuilderBuilder.new(Foo)
    builder_builder.add_rule do
      !foo.nil?
    end

    builder = builder_builder.build

    expect do
      builder.build
    end.to raise_exception(ValidationError)
  end

  it 'Trying to build with foo > 3 and foo not nil should raise Contingency' do
    builder_builder = BuilderBuilder.new(Foo)
    builder_builder.add_rule do
      foo > 3
    end

    builder_builder.add_rule do
      foo != nil
    end

    builder = builder_builder.build(true, true)
    builder.foo = 42
    builder.bar = 'bar'

    expect(builder.foo).to eq(42)
    expect(builder.bar).to eq('bar')

    a = builder.build
    expect(a.foo).to eq(42)
    expect(a.bar).to eq('bar')
  end

  it 'Building a builder with contradictory rules should raise Contradiction Error' do
    builder_builder = BuilderBuilder.new(Foo)
    builder_builder.add_rule do
      foo == 42
    end

    builder_builder.add_rule do
      foo != 42
    end

    expect do
      builder_builder.build(true, false)
    end.to raise_exception(ContradictionError)
  end


end