require 'rspec'
require_relative '../lib/Rule/rule'
require_relative '../lib/Builder/builder.rb'
require_relative '../lib/Builder/builder_builder.rb'
require_relative '../../src/lib/Exception/validation_error'
require_relative '../lib/Object/object'

describe 'BuilderBuilder spec' do
  class A
    attr_reader :foo, :bar

    def initialize(a, b)
      @foo = foo
      @bar = bar
    end
  end

  rule = Rule.new do
    !foo.nil? && !bar.nil?
  end

  it 'Trying to build without setting values should raise validation error' do
    builderBuilder = BuilderBuilder.new(A)
    builderBuilder.add_rule do
      !foo.nil?
    end

    builder = builderBuilder.build

    expect do
      builder.build
    end.to raise_exception(ValidationError)
  end
end