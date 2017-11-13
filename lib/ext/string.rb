class String
  def ios_token
    "<%s %s %s %s %s %s %s %s>" % self.gsub(' ', '').scan(/([a-zA-Z0-9]{8})/).flatten
  rescue
    self
  end
end
