# encoding: utf-8
class BannerUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :original do
    process :resize_to_exactly => [1500, 500]
  end

  version :thumb do
    process :resize_to_exactly => [150, 50]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png)
  end

  def filename
    "#{ model.locale }.#{ file.extension }" if original_filename.present?
  end

  def resize_to_exactly(width, height)
    manipulate! do |img|
      img.resize "#{width}x#{height}!"
      img = yield(img) if block_given?
      img
    end
  end
end
