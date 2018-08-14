# frozen_string_literal: true

require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  test 'image quality can be set' do
    activate_plugin
    set_image_quality 90
    set_image_quality 10
  end

  def test_plugin_works_via_hook
    orig = 'test/dummy/app/assets/images/orig.jpg'
    file = 'test/dummy/app/assets/images/test.jpg'
    FileUtils.cp orig, file

    deactivate_plugin
    plugin_via_hook file
    assert FileUtils.identical?(orig, file), 'Plugin modified file via hook when deactivated.'

    activate_plugin
    plugin_via_hook file
    assert File.size(file) < File.size(orig), 'Plugin failed to operate via hook.'
  ensure
    FileUtils.rm file
  end

  private

  def activate_plugin
    admin_sign_in
    get 'http://localhost:3000/admin/plugins/toggle?id=camaleon_image_optimizer&status=false'
    follow_redirect!
    assert_equal 'Plugin "Camaleon Image Optimizer" was activated.', flash[:notice]
    get 'http://localhost:3000/admin/plugins/camaleon_image_optimizer/settings'
    assert_response :ok, 'Plugin settings page could not be accessed at http://localhost:3000/admin/plugins/camaleon_image_optimizer/settings'
  end

  def deactivate_plugin
    admin_sign_in
    get 'http://localhost:3000/admin/plugins/toggle?id=camaleon_image_optimizer&status=true'
    follow_redirect!
    assert_equal 'Plugin "Camaleon Image Optimizer" was inactivated.', flash[:notice]
    get 'http://localhost:3000/admin/plugins/camaleon_image_optimizer/settings'
    assert_response :found, 'Plugin did not correctly redirect request to settings page when plugin was inactive'
  end

  def set_image_quality(quality)
    post 'http://localhost:3000/admin/plugins/camaleon_image_optimizer/save_settings', params: {
      options: { quality: quality }
    }
    follow_redirect!
    assert_equal 'Settings Saved Successfully', flash[:notice]
    assert_select "input[value=\"#{quality}\"]", '', 'The saved "Quality" value did not appear in the settings form after saving'
  end

  def plugin_via_hook(file)
    CamaleonCms::AdminController.new.hooks_run 'before_upload', uploaded_io: File.open(file)
  end

  def admin_sign_in(user = 'admin', pass = 'admin123')
    current_site.set_option 'date_notified', Date.today # Avoid weird threading bug
    post 'http://localhost:3000/admin/login', params: {
      user: { username: user, password: pass }
    }
    follow_redirect!
    assert_equal 'Welcome!!!', flash[:notice], 'Login failed'
  end

  def current_site
    CamaleonCms::Site.first.decorate
  end
end
