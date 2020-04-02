# DefineMethods

Defines multiple methods with common behavior.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'define_methods'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install define_methods

## Usage

Here's a class with similar methods.

```ruby
class Greet
  def hi(greeted)
    "Hi #{greeted}!"
  end

  def hello(greeted)
    "Hello #{greeted}!"
  end

  def goodbye(greeted)
    "Goodbye #{greeted}!"
  end
end

greet = Greet.new
greet.hello('world') # => "Hello world!"
greet.goodbye('world') # => "Goodbye world!"
```

### DefineMethods#define_methods

Defines methods just like [Module#define_method](https://apidock.com/ruby/Module/define_method). However it accepts a list of method names as arguments. To use it, just extend the class like so.

```ruby
class Greet
  extend DefineMethods

  define_methods(:hi, :hello, :goodbye) do |greeted|
    "#{__method__.capitalize} #{greeted}!"
  end
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/richorelse/define_methods.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
