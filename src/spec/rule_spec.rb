require 'rspec'
require_relative '../lib/Rule/rule'

describe 'Rule spec' do
  class A
    attr_accessor :foo

    def initialize(value)
      self.foo = value
    end
  end

  map = RuleMap.new

  rule = Rule.new(map) do
    foo > 3
  end

  it 'An instance of A with foo = 42 should satisfy the rule' do
    expect(rule.satisfies?(A.new(42))).to be_truthy
  end

  it 'An instance of A with foo = 2 should not satisfy the rule' do
    expect(rule.satisfies?(A.new(2))).to be_falsey
  end

  it 'An instance of B should raise NameError' do
    expect do
      class SomeClass
      end

      rule.satisfies?(SomeClass.new)
    end.to raise_exception(NameError)
  end

  it 'Rule foo > 30 as a proposition should be foo then a' do
    rule = Rule.new(RuleMap.new) do
      foo > 30
    end

    expect(rule.as_proposition).to eq('foo then a')
  end

  it 'Rule foo > 0 and foo < 0 should be a contradiction' do
    rule_map = RuleMap.new

    bigger_than = Rule.new(rule_map) do
      foo > 0
    end

    lesser_than = Rule.new(rule_map) do
      foo < 0
    end

    expect(lesser_than.as_proposition).to eq('foo then ! a')
    expect(bigger_than.as_proposition).to eq('foo then a')
  end
end