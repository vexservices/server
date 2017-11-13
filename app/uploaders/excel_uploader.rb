# encoding: utf-8
class ExcelUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def path_or_url
    if Rails.env.development? || Rails.env.test?
      self.path
    else
      self.url
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(ods xls xlsx csv)
  end
end
