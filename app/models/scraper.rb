class Scraper
  require 'httparty'
  require 'nokogiri'

  # Generic method to fetch and parse HTML document
  def self.fetch_data(url)
    headers = {
      "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/601.5.17 (KHTML, like Gecko) Version/9.1 Safari/601.5.17"
    }
    Nokogiri::HTML(HTTParty.get(url, headers: headers))
  end

  # specify URL to making API call to
  def self.get_product_info(asin)
    url = "https://www.amazon.com/dp/#{asin}"
    parsed_html = fetch_data(url)
    {
      name: name(parsed_html),
      category: category(parsed_html),
      rank: rank(parsed_html),
      dimensions: dimensions(parsed_html)
    }
  end

  # Search product name by CSS
  def self.name(data)
    data.css('#productTitle').first.children.text.lstrip!.rstrip!.squish
  end

  # Search for category by CSS
  def self.category(data)
    data.css('.a-color-tertiary').first.children.text.lstrip!.rstrip!.squish
  end

  # Search for rank by CSS
  def self.rank(data)
    data.css('.zg_hrsr_item ,.zg_hrsr_rank').first.children.text.lstrip!.rstrip!.squish
  end

  # Search for dimensions by CSS
  def self.dimensions(data)
    data.css('.size-weight+ .size-weight .value').first.children.text
  end
end

