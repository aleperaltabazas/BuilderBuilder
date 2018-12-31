require 'rspec'
require_relative '../lib/Rule/rule'

describe 'Rule spec' do
  class Foo
    attr_accessor :foo

    def initialize(value)
      self.foo = value
    end
  end

  rule = Rule.new do
    foo > 3
  end

  it 'An instance of A with foo = 42 should satisfy the rule' do
    expect(rule.satisfies?(Foo.new(42))).to be_truthy
  end

  it 'An instance of A with foo = 2 should not satisfy the rule' do
    expect(rule.satisfies?(Foo.new(2))).to be_falsey
  end

  it 'An instance of B should raise NameError' do
    expect do
      class B
      end

      rule.satisfies?(B.new)
    end.to raise_exception(NameError)
  end
end