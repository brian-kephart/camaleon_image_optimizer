module Plugins::CamaleonImageOptimizer::MainHelper
  require 'image_optim'

  def self.included(klass)
    # klass.helper_method [:my_helper_method] rescue "" # here your methods accessible from views
  end

  # here all actions on going to active
  # you can run sql commands like this:
  # results = ActiveRecord::Base.connection.execute(query);
  # plugin: plugin model
  def camaleon_image_optimizer_on_active(plugin)
  end

  # here all actions on going to inactive
  # plugin: plugin model
  def camaleon_image_optimizer_on_inactive(plugin)
  end

  # here all actions to upgrade for a new version
  # plugin: plugin model
  def camaleon_image_optimizer_on_upgrade(plugin)
  end

  # hook listener to add settings link below the title of current plugin (if it is installed)
  # args: {plugin (Hash), links (Array)}
  # permit to add unlimmited of links...
  def camaleon_image_optimizer_on_plugin_options(args)
    args[:links] << link_to('Settings', admin_plugins_camaleon_image_optimizer_settings_path)
  end

  def cama_optimize_image(settings)
    # settings in config/image_optim.yml
    spec = Gem::Specification.find_by_name("camaleon_image_optimizer")
    gem_root = Pathname.new spec.gem_dir
    image_optim = ImageOptim.new YAML.load_file(gem_root.join('config', 'image_optim.yml'))
    image_optim.optimize_image! settings[:uploaded_io].path
    settings[:uploaded_io] = File.open settings[:uploaded_io].path
  end

end
