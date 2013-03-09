# Glimpse::Redis

Provide a glimpse into the Redis calls made within your Rails application.

Things this glimpse view provides:

- Total number of Redis commands called during the request
- The duration of the calls made during the request

## Installation

Add this line to your application's Gemfile:

    gem 'glimpse-redis'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install glimpse-redis

## Usage

Add the following to your `config/initializers/glimpse.rb`: 

```ruby
Glimpse.into Glimpse::Views::Redis
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
