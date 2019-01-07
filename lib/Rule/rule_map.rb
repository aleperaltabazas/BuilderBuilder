class RuleMap
  attr_accessor :hash_map, :var

  def initialize
    self.hash_map = {}
    self.var = 'a'
  end

  def fetch(object)
    unless hash_map.key?(object)
      hash_map[object] = var.to_s
      self.var = var.next
    end

    hash_map[object]
  end
end