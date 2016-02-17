# Picfit [![Build Status](https://travis-ci.org/edgar/picfit-ruby.png?branch=master)](https://travis-ci.org/edgar/picfit-ruby) [![Gem Version](https://badge.fury.io/rb/picfit.svg)](http://badge.fury.io/rb/picfit)

A Ruby library for generating URLs with [picfit](https://github.com/thoas/picfit).

Inspired by [picfit-go](https://github.com/ulule/picfit-go)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'picfit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install picfit

## Usage

```ruby
# Initialize Picfit with a block
Picfit.configure do |config|
  config.base_url = "http://mypicfitserver.com",
  config.secret_key = "abcdef"
end

# Or initialize using a Hash
Picfit.init(base_url: "http://mypicfitserver.com", secret_key: "abcdef")

# Get the image url
Picfit.image_url(
  width: 100,
  height: 100,
  path: "path/to/file",
  operation: :resize
)
=> "http://mypicfitserver.com/display?path=path%2Fto%2Ffile&op=resize&w=100&h=100&sig=f45506bf02ca3ba84eb34a2a066af7aa315a11c2"

# Get the image path (without base_url)
Picfit.image_path(
  width: 100,
  height: 100,
  path: "path/to/file",
  operation: :resize,
)
=> "display?path=path%2Fto%2Ffile&op=resize&w=100&h=100&sig=f45506bf02ca3ba84eb34a2a066af7aa315a11c2"
```

### General parameters

The `Hash` parameter supplied to both `image_path` and `image_url` methods support the following keys (as a `Symbol`:

- **:path** - The filepath to load the image using your source storage
- **:operation** - The operation to perform, see (Operations)[https://github.com/thoas/picfit#operations]
- **:secret_key** - Your secret key, see (Security)[https://github.com/thoas/picfit#security]
- **:method** - The method to perform, see (Methods)[https://github.com/thoas/picfit#methods]
- **:url** - The url of the image to generate (not required if ``path`` provided)
- **:width** - The desired width of the image, if ``0`` is provided the service will calculate the ratio with ``height``
- **:height** - The desired height of the image, if ``0`` is provided the service will calculate the ratio with ``width``
- **:upscale** - If your image is smaller than your desired dimensions, the service will upscale it by default to fit your dimensions, you can disable this behavior by providing ``0``
- **format** - The output format to save the image, by default the format will be the source format (a ``GIF`` image source will be saved as ``GIF``),  see Formats_
- **quality** - The quality to save the image, by default the quality will be the highest possible, it will be only applied on ``JPEG`` format
- **degree** - The degree (``90``, ``180``, ``270``) to rotate the image
- **position** - The position to flip the image

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/picfit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
