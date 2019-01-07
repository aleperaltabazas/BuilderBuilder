class Object
  def self.attr_reader(*vars)
    @attributes ||= []
    @attributes.concat vars
    super(*vars)
  end

  def self.attributes
    @attributes ||= []
    @attributes
  end

  def attributes
    self.class.attributes
  end
end