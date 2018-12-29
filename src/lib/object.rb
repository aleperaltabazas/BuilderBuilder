require_relative 'attributes'

class Object
  private

  attr_accessor :attrs

  public

  def self.attr_reader(*vars)
    self.attrs = Attributes.new if attrs.nil?

    attrs.add_readers(vars)
    super(*vars)
  end

  def self.attr_accessor(*vars)
    self.attrs = Attributes.new if attrs.nil?

    attrs.add_accessors(vars)
    super(*vars)
  end

  def self.attributes
    if attrs.nil?
      []
    else
      attrs.all_attributes.flatten
    end
  end

  def attributes
    self.class.attributes
  end

  private
end