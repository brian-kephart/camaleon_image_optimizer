# Camaleon Image Optimizer
This is a convenient image optimizer plugin for Camaleon CMS. Compressing images improves load times and thus SEO. It uses the [image_optim gem](https://github.com/toy/image_optim) under the hood. This gem contains multiple utilities for compressing GIF, JPEG, PNG, and SVG files. My experience has been that GIFs JPEGs are easily crushable with these tools, but using multiple PNG compressors is extremely slow. Thus, only one of the PNG compressors is enabled here.

Currently the only setting exposed by the plugin is `max_quality`, affecting JPEG and PNG images. Please note that setting this to the maximum will still result in some compression.

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

If you need support for compressing SVG files, install [SVGO](https://github.com/svg/svgo). Note that you need to do this on your production server, and you must first have NPM installed.
```bash
$ npm install -g svgo
```

If you instead install SVGO locally:
```bash
$ npm install svgo
```
or:
```bash
$ yarn add svgo
```
...then you must add this variable to your Production environment:
```
SVGO_BIN='node_modules/svgo/bin/svgo'
```

## Usage
Just activate the plugin in Camaleon's admin panel.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
