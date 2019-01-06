require 'sourcify'
require 'logic_analyzer'
require_relative '../Contradiction/context_provider'
require_relative 'rule_map'

class Rule
  attr_accessor :rule, :map

  def initialize(map, &block)
    self.rule = Proc.new(&block)
    self.map = map
  end

  def satisfies?(object)
    object.instance_eval(&rule)
  end

  def contradictory?(other_rule)
    analyzer = LogicAnalyzer.new(as_proposition, other_rule.as_proposition)
    analyzer.parse
    !analyzer.evaluate
  end

  def as_proposition
    rule.to_source(strip_enclosure: true).gsub(/>|>=/, 'then')
        .gsub(/<|<=/, 'then !')
        .gsub(/==|equal\?/, 'only_if')
        .gsub(/nil\?/, '!= nil')
        .gsub(/\d+/) do |match|
      map.fetch(match)
    end
        .tr('.', ' ')
  end
end
