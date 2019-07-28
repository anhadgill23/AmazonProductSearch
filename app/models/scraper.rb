class Scraper
  require 'nokogiri'
  require 'httparty'

  # Generic method to fetch and parse HTML document
  def self.fetch_data(url)
    headers = {
      "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/601.5.17 (KHTML, like Gecko) Version/9.1 Safari/601.5.17"
    }
    Nokogiri::HTML(HTTParty.get(url, headers: headers))
  end

  # specify URL to making API call to
  def self.store_data
    url = 'https://www.amazon.com/dp/B002QYW8LW'
    url2 = 'https://www.amazon.com/dp/B00M9K7L8S'
    fetch_data(url)
  end

  # Search for category by CSS
  def self.search_category
    store_data.css('.a-color-tertiary').first.children.text.lstrip!.rstrip!.squish
  end

  # Search for rank by CSS
  def self.search_rank
    store_data.css('.zg_hrsr_item , .zg_hrsr_rank').first.children.text.lstrip!.rstrip!.squish
  end

  # Search for dimensions by CSS
  def self.search_dimensions
    store_data.css('.size-weight+ .size-weight .value').first.children.text
  end
end

