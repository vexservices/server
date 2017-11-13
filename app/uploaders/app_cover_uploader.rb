# encoding: utf-8
require 'carrierwave/processing/mini_magick'
class AppCoverUploader < CarrierWave::Uploader::Base

  include ::CarrierWave::Backgrounder::Delay
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # name: 320x480
  version :version1 do
    process :resize_to_exactly => [320, 480]
  end

  # name: 640x960
  version :version2 do
    process :resize_to_exactly => [640, 960]
  end

  # name: 640x1136
  version :version3 do
    process :resize_to_exactly => [640, 1136]
  end

  # name: 768x1004
  version :version4 do
    process :resize_to_exactly => [768, 1004]
  end

  # name: 1024x748
  version :version5 do
    process :resize_to_exactly => [1024, 748]
  end

  # name: 1536x2048
  version :version5 do
    process :resize_to_exactly => [1536, 2048]
  end

  # name: 2048x1536
  version :version6 do
    process :resize_to_exactly => [2048, 1536]
  end

  # for image size validation
  # fetching dimensions in uploader, validating it in model
  before :cache, :capture_size_before_cache # callback, example here: http://goo.gl/9VGHI
  def capture_size_before_cache(new_file)
    if model.image_upload_width.nil? || model.image_upload_height.nil?
      model.image_upload_width, model.image_upload_height = `identify -format "%wx %h" #{new_file.path}`.split(/x/).map { |dim| dim.to_i }
    end
  end

  def resize_to_exactly(width, height)
    manipulate! do |img|
      img.resize "#{width}x#{height}!"
      img = yield(img) if block_given?
      img
    end
  end

  def extension_white_list
    %w(png jpg jpeg)
  end
end
