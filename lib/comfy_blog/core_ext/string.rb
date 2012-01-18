class String
  
  # Transforms strings into a nice, URL-friendly format
  def slugify
    self.downcase.gsub(/\W|_/, ' ').strip.squeeze(' ').gsub(/\s/, '-')
  end
  
end