# Camaleon Image Optimizer
This is a convenient image optimizer plugin for Camaleon CMS. Compressing images improves load times and thus SEO. It uses the [image_optim gem](https://github.com/toy/image_optim) under the hood. This gem contains multiple utilities for compressing JPEG and PNG files. My experience has been that JPEGs are super crushable with these tools, but using multiple PNG compressors is extremely slow. Thus, only one of the PNG compressors is enabled here.

Currently the only setting exposed by the plugin is `max_quality`, affecting only JPEG images. Please note that since there are multiple JPEG compressors, setting this to the maximum will still result in some compression.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'camaleon_image_optimizer'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install camaleon_image_optimizer
```

## Usage
Just activate the plugin in Camaleon's admin panel.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
