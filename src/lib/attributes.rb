class Attributes
  attr_accessor :accessors, :readers

  def add_readers(*readers)
    self.readers ||= []
    self.readers.concat readers
  end

  def add_accessors(accesors)
    self.accessors ||= []
    self.accessors.concat accesors
  end

  def get_all
    self.readers.concat self.accessors
  end
end