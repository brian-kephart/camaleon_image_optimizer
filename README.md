# Camaleon Image Optimizer
This is a convenient image optimizer plugin for Camaleon CMS. Compressing images improves load times and thus SEO. It uses the [image_optim_rails gem](https://github.com/toy/image_optim_rails) under the hood. Currently no settings are exposed in Camaleon, but that may happen in the future. Until then, the default settings will still compress quite a bit without sacrificing quality.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'camaleon_image_optimizer', github: 'brian-kephart/camaleon_image_optimizer'
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
