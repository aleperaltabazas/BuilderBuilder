require 'rspec'
require_relative '../lib/Object/object'

describe 'Attributes spec' do
  it 'Defining only readers should still give me a list of the attributes' do
    class Foo
      attr_reader :a, :b
    end

    a = Foo.new
    expect(a.attributes).to eq(%i[a b])
  end

  it 'Defining only accessors should give me an empty list' do
    class B
      attr_accessor :a, :b
    end

    b = B.new
    expect(b.attributes).to eq([])
  end

  it 'Defining both accessors and readers should give me a list with the readers' do
    class C
      attr_accessor :a, :b
      attr_reader :c, :d
    end

    c = C.new
    expect(c.attributes).to eq(%i[c d])
  end
end