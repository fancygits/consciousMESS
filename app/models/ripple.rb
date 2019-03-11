class Ripple < ApplicationRecord
  validates :name, :message, presence: true
  validates_format_of :url, allow_blank: true, :with => /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i
  after_validation :sanitize_url

  
  def sanitize_url
    return if url.blank?
    url = URI.parse(self.url) rescue false
    self.url = "http://#{self.url}" unless url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end
end
