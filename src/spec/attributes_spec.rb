require 'rspec'

describe 'Attributes spec' do
  class A
    include Attributes
    attr_accessor :a, :b
  end

  it 'An object instance of Attributes should give me its attributes' do

  end
end