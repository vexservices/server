# encoding: utf-8
require 'carrierwave/processing/mini_magick'
class AppImageUploader < CarrierWave::Uploader::Base

  include ::CarrierWave::Backgrounder::Delay
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # name: icon-small
  version :version1 do
    process :resize_to_exactly => [29, 29]
  end

  # name: 36x36
  version :version2 do
    process :resize_to_exactly => [36, 36]
  end

  # name: icon-40
  version :version3 do
    process :resize_to_exactly => [40, 40]
  end

  # name: 48x48
  version :version4 do
    process :resize_to_exactly => [48, 48]
  end

  # name: icon-50
  version :version5 do
    process :resize_to_exactly => [50, 50]
  end

  # name: icon
  version :version6 do
    process :resize_to_exactly => [57, 57]
  end

  # name: icon-small@2x
  version :version7 do
    process :resize_to_exactly => [58, 58]
  end

  # name: icon-60
  version :version8 do
    process :resize_to_exactly => [60, 60]
  end

  # name: icon-72
  version :version9 do
    process :resize_to_exactly => [72, 72]
  end

  # name: icon-76
  version :version10 do
    process :resize_to_exactly => [76, 76]
  end

  # name: icon-40@2x
  version :version11 do
    process :resize_to_exactly => [80, 80]
  end

  # name: 96x96
  version :version12 do
    process :resize_to_exactly => [96, 96]
  end

  # name: icon-50@2x
  version :version13 do
    process :resize_to_exactly => [100, 100]
  end

  # name: icon-72@2x
  version :version14 do
    process :resize_to_exactly => [114, 114]
  end

  # name: icon-60@2x
  version :version15 do
    process :resize_to_exactly => [120, 120]
  end

  # name: 128x128
  version :version16 do
    process :resize_to_exactly => [128, 128]
  end

  # name: icon@2x
  version :version17 do
    process :resize_to_exactly => [144, 144]
  end

  # name: icon-76@2x
  version :version18 do
    process :resize_to_exactly => [152, 152]
  end

  # name: 170x200
  version :version19 do
    process :resize_to_exactly => [170, 200]
  end

  # name: Default~iphone
  version :version20 do
    process :resize_to_exactly => [320, 480]
  end

  # name: 512x512
  version :version21 do
    process :resize_to_exactly => [512, 512]
  end

  # name: Default@2x~iphone
  version :version22 do
    process :resize_to_exactly => [640, 960]
  end

  # name: Default-568h@2x~iphone
  version :version23 do
    process :resize_to_exactly => [640, 1136]
  end

  # name: Default-Portrait~ipad
  version :version24 do
    process :resize_to_exactly => [768, 1004]
  end

  # name: 768x1024
  version :version25 do
    process :resize_to_exactly => [768, 1024]
  end

  # name: 1024x748
  version :version26 do
    process :resize_to_exactly => [1024, 748]
  end

  # name: icon-store
  version :version27 do
    process :resize_to_exactly => [1024, 1024]
  end

  # name: 1024x500
  version :version28 do
    process :resize_to_exactly => [1024, 500]
  end

  # name: Default-Landscape~ipad
  version :version29 do
    process :resize_to_exactly => [1024, 748]
  end

  # name: 1536x2008
  version :version30 do
    process :resize_to_exactly => [1536, 2008]
  end

  # name: Default-Portrait@2x~ipad
  version :version31 do
    process :resize_to_exactly => [1536, 2048]
  end

  # name: 2048x1496
  version :version32 do
    process :resize_to_exactly => [2048, 1496]
  end

  # name: Default-Landscape@2x~ipad
  version :version33 do
    process :resize_to_exactly => [2048, 1536]
  end

  def resize_to_exactly(width, height)
    manipulate! do |img|
      img.resize "#{width}x#{height}!"
      img = yield(img) if block_given?
      img
    end
  end

  # for image size validation
  # fetching dimensions in uploader, validating it in model
  before :cache, :capture_size_before_cache # callback, example here: http://goo.gl/9VGHI
  def capture_size_before_cache(new_file)
    if model.image_upload_width.nil? || model.image_upload_height.nil?
      model.image_upload_width, model.image_upload_height = `identify -format "%wx %h" #{new_file.path}`.split(/x/).map { |dim| dim.to_i }
    end
  end

  def extension_white_list
    if model.skip_extension_with_list
      %w(png jpg)
    else
      %w(png jpg jpeg)
    end
  end
end
