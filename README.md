# BrightpearlApi

Gem for connecting to your brightpearl account via their API

## Installation

Add this line to your application's Gemfile:

    gem 'brightpearl_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install brightpearl_api

## Usage

### Initialize

Refer [Brightpearl Documentation](http://www.brightpearl.com/developer/latest/tutorial/getting-started.html) for values.

In ```config/initializers/brightpearl_api.rb```

With Environment Variables set

```(ENV['BRIGHTPEARL_EMAIL'], ENV['BRIGHTPEARL_PASSWORD'], ENV['BRIGHTPEARL_VERSION'], ENV['BRIGHTPEARL_DATACENTER'], ENV['BRIGHTPEARL_ACCOUNT'])```

```
BrightpearlApi.configure do
end
```

Else

```
BrightpearlApi.configure do |c|
  c.email = 'someone@example.com'
  c.password = 'something'
  c.version = '2.0.0'
  c.datacenter = 'ws-usw'
  c.account = 'myaccount'
end
```

## Contributing

1. Fork it ( http://github.com/kitwalker12/brightpearl_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
