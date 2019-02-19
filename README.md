# Builder Builder
Yes, another Builder's Builder, or MetaBuilder, implemented in Ruby.
The Builder Builder "framework" generifies the logic of a Builder class, this being validating a series of restrictions (or rules) before creating a new object of a certain class. So, how can you do this? Well, it's pretty simple. You just need to instantiate a BuilderBuilder for a target class and its set of rules. 

Let's get at it with an example.

```ruby
require 'builder_builder'

class SomeClass
  def initialize(foo, bar)
    @foo = foo
    @bar = bar
  end

  attr_accessor :foo, :bar
  
  def say_foo
    :foo
  end
end

builder_builder = BuilderBuilder.new(SomeClass.class, [:foo, :bar])
# note that the order of the parameters is the same as the constructor for SomeClass, 
# since this array will then be used to instantiate SomeClass in a built builder
builder_builder.add_rule {
  foo > 3
end

builder = builder_builder.build(true, true)
...
```

Hold on a second, what's with those flags?

Well, the first one is wether you _want_ the analyzer to check for contradictions, and the second one if you want to catch a contingency. Let me start with the second one. 
Logically speaking, a contingency occurs when the truth value for a proposition is not either true or false; under certain circumstances it _might be_ true, and in other it _might be_ false. I'd recommend to set it as true, because if you have two unrelated rules (say, foo > 3 and bar != nil), I'm almost certain it'd trigger a contingency (although I'm thinking of changing the default value of false to true).
On the other hand, since the logic analyzer is, sadly, not perfect, there might be cases in which it'll detect a contradiction where there may not be one, so the first flag is wether you want to validate the contradictions or not. I'm sure that the analyzer could be improved (and... I think I probably should), but set it as true, and if it fails in a case you know should run, please report the issue with the problem rules.

That said, after you create your builder, the rest is pretty straightforward.
```ruby
...
builder.foo = 4
# upon being created, the builder is set with the parameters array passed before to the builder_builder
builder.bar = 'Hey there'

some_object = builder.build
some_object.say_foo
> 4
```

Finally, to install just run ```gem install builder_builder``` and then include the gem in your project.
