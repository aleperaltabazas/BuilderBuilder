require 'rspec'
require_relative '../lib/rule'

describe 'Rule spec' do
  class A
    attr_accessor :foo

    def initialize(value)
      self.foo = value
    end
  end

  rule = Rule.new do
    foo > 3
  end

  it 'An instance of A with foo = 42 should satisfy the rule' do
    expect(rule.satisfies?(A.new(42))).to be_truthy
  end

  it 'An instance of A with foo = 2 should not satisfy the rule' do
    expect(rule.satisfies?(A.new(2))).to be_falsey
  end
end