class Attributes
  attr_accessor :accessors, :readers

  def add_readers(*readers)
    self.readers ||= []
    self.readers.concat readers
  end

  def add_accessors(*accesors)
    self.accessors ||= []
    self.accessors.concat accesors
  end

  def all_attributes
    if readers.nil? && accessors.nil?
      []
    elsif readers.nil?
      accessors
    elsif accessors.nil?
      readers
    else
      readers.concat accessors
    end
  end
end