module Plugins::CamaleonImageOptimizer::MainHelper
  require 'image_optim'

  def self.included(klass)
    # klass.helper_method [:my_helper_method] rescue "" # here your methods accessible from views
  end

  def camaleon_image_optimizer_on_active(plugin)
    camaleon_image_optimizer_options plugin
  end

  def camaleon_image_optimizer_on_inactive(plugin)
  end

  def camaleon_image_optimizer_on_upgrade(plugin)
    camaleon_image_optimizer_options plugin
  end

  def camaleon_image_optimizer_on_plugin_options(args)
    args[:links] << link_to('Settings', admin_plugins_camaleon_image_optimizer_settings_path)
  end

  def cama_optimize_image(settings)
    image_optim = ImageOptim.new camaleon_image_optimizer_settings
    image_optim.optimize_image! settings[:uploaded_io].path
    settings[:uploaded_io] = File.open settings[:uploaded_io].path
  end

private

  def camaleon_image_optimizer_options(plugin)
    plugin.set_option('quality', camaleon_image_optimizer_default_settings['jpegoptim']['max_quality']) unless plugin.get_option('quality').present?
  end

  def camaleon_image_optimizer_settings
    @camaleon_image_optimizer_settings ||= camaleon_image_optimizer_default_settings.tap do |cios|
      unless current_plugin.get_option('quality').blank?
        cios['jpegoptim']['max_quality'] = current_plugin.get_option 'quality'
        cios['pngquant']['quality'] = (0..current_plugin.get_option('quality'))
      end
    end
  end

  def camaleon_image_optimizer_default_settings
    @camaleon_image_optimizer_default_settings ||= begin
      # default settings in config/image_optim.yml
      spec = Gem::Specification.find_by_name 'camaleon_image_optimizer'
      gem_root = Pathname.new spec.gem_dir
      YAML.load_file gem_root.join('config', 'image_optim.yml')
    end
  end

end
