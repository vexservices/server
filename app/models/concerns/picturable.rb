module Picturable
  def image(size = :thumb)
    img = pictures.first
    img = img.blank? ? "#{ self.class.name.downcase }/#{ size.to_s}.png" : img.file.url(size)
  end
end
