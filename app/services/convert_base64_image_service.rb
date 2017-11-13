class FilelessIO < StringIO
  attr_accessor :original_filename
end

class ConvertBase64ImageService

  def self.call(base64_encoded_image, filename = 'original.jpg')
    split_encoded = Base64.decode64(base64_encoded_image)
    io = FilelessIO.new(split_encoded)
    io.original_filename = filename

    io
  end
end
