# frozen_string_literal: true

require 'test_helper'

class CamaleonImageOptimizer::Test < ActiveSupport::TestCase
  ORIG_JPG = 'test/dummy/app/assets/images/orig.jpg'
  TEST_JPG = 'test/dummy/app/assets/images/test.jpg'
  ORIG_PNG = 'test/dummy/app/assets/images/orig.png'
  TEST_PNG = 'test/dummy/app/assets/images/test.png'
  ORIG_GIF = 'test/dummy/app/assets/images/orig.gif'
  TEST_GIF = 'test/dummy/app/assets/images/test.gif'
  ORIG_SVG = 'test/dummy/app/assets/images/orig.svg'
  TEST_SVG = 'test/dummy/app/assets/images/test.svg'

  CONTROLLER = Plugins::CamaleonImageOptimizer::AdminController

  def setup
    FileUtils.cp ORIG_JPG, TEST_JPG
    FileUtils.cp ORIG_PNG, TEST_PNG
    FileUtils.cp ORIG_GIF, TEST_GIF
    FileUtils.cp ORIG_SVG, TEST_SVG
  end

  def teardown
    FileUtils.rm [TEST_JPG, TEST_PNG, TEST_GIF, TEST_SVG]
  end

  test 'truth' do
    assert_kind_of Module, CamaleonImageOptimizer
  end

  test 'image optimizer reduces image size of JPG or PNG according to settings' do
    test_compression_jpg_png TEST_JPG
    test_compression_jpg_png TEST_PNG
  end

  test 'image optimizer reduces size of GIF' do
    original_size = File.size TEST_GIF
    CONTROLLER.new.cama_optimize_image uploaded_io: File.open(TEST_GIF)
    compressed_size = File.size TEST_GIF
    assert compressed_size < original_size, 'Image optimizer failed to reduce file size of GIF.'
  end

  test 'image optimizer reduces size of SVG' do
    # SVGO requires separate installation. See README.md.
    `yarn add svgo`
    # Path to SVGO binary must be specified for non-global installation.
    ENV['SVGO_BIN'] = 'node_modules/svgo/bin/svgo'

    original_size = File.size TEST_SVG
    CONTROLLER.new.cama_optimize_image uploaded_io: File.open(TEST_SVG)
    compressed_size = File.size TEST_SVG
    assert compressed_size < original_size, 'Image optimizer failed to reduce file size of SVG.'
  end

  test 'does not blow up without svgo' do
    `yarn remove svgo`
    ENV.delete 'SVGO_BIN'
    CONTROLLER.new.cama_optimize_image uploaded_io: File.open(TEST_SVG)
    assert FileUtils.identical?(ORIG_SVG, TEST_SVG), 'Test SVG was modified when it should not have been.'
  end

  private

  def test_compression_jpg_png(img)
    type = img.split('.').last.upcase
    plugin = CONTROLLER.new.current_site.get_plugin 'camaleon_image_optimizer'

    original_size = File.size img

    plugin.set_option 'quality', '100'
    CONTROLLER.new.cama_optimize_image uploaded_io: File.open(img)
    compressed_size = File.size img
    assert compressed_size < original_size, "Image optimizer failed to reduce file size of #{type}."

    plugin.set_option 'quality', '1'
    CONTROLLER.new.cama_optimize_image uploaded_io: File.open(img)
    smooshed_size = File.size img
    assert smooshed_size < compressed_size, "Extreme settings failed to further reduce file size of #{type}."
  end
end
