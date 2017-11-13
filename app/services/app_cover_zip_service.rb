require 'zip'
require "httparty"

class AppCoverZipService
  attr_accessor :image, :zip_data
  def initialize(image)
    @image = image
  end

  def compress
    temp_file = Tempfile.new('app_logo')

    begin
      if Rails.env.development? || Rails.env.test?
        from_local_files(temp_file)
      else
        from_cloud_files(temp_file)
      end

      @zip_data = File.read(temp_file.path)
    ensure
      temp_file.close
      temp_file.unlink
    end
  end

  def from_local_files(file)
    Zip::OutputStream.open(file) { |zos| }

    Zip::File.open(file.path, Zip::File::CREATE) do |zipfile|
      (1..6).each do |number|
        path = eval("image.app_cover.version#{ number }.path")
        filename = "version_#{ number }.#{ image.app_cover.file.extension }"

        zipfile.add(filename, path) if filename.present?
      end
    end
  end

  def from_cloud_files(file)
    Zip::OutputStream.open(file.path) do |zos|
      (1..6).each do |number|
        path = image.app_cover.url("version#{ number }")
        filename = "version_#{ number }.#{ image.app_cover.file.extension }"

        temp_file = Tempfile.new("version_#{ number }")

        Rails.logger.info "Download #{ path } in #{ temp_file.path }"

        File.open(temp_file.path, "wb") do |f|
          f.write HTTParty.get(path).parsed_response
        end

        zos.put_next_entry(filename)
        zos.print IO.read(temp_file.path)
      end
    end
  end
end
