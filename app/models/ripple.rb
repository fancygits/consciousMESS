class Ripple < ApplicationRecord
  before_save :sanitize_url

  
  def sanitize_url
    return if url.blank?
    url = URI.parse(self.url) rescue false
    self.url = "http://#{self.url}" unless url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end
end
