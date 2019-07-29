class Scraper
  require 'httparty'
  require 'nokogiri'

  # Generic method to fetch HTML document
  def self.fetch_data(url)
    headers = {
      "User-Agent": 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/601.5.17 (KHTML, like Gecko) Version/9.1 Safari/601.5.17'
    }
    Nokogiri::HTML(HTTParty.get(url, headers: headers))
  end

  # specify URL to making API call to
  def self.get_product_info(asin)
    url = "https://www.amazon.com/dp/#{asin}"
    response = fetch_data(url)
    return response if response.nil?

    {
      name: name(response),
      category: category(response),
      rank: rank(response),
      dimensions: dimensions(response)
    }
  end

  # Search product name by CSS
  def self.name(data)
    name = data.css('#productTitle')
    name.present? ? name.first.try(:children).try(:text).lstrip!.rstrip!.squish : nil
  end

  # Search for category by CSS
  def self.category(data)
    category = data.css('.a-color-tertiary')
    category.present? ? category.first.try(:children).try(:text).lstrip!.rstrip!.squish : nil
  end

  # Search for rank by CSS
  def self.rank(data)
    rank = data.css('#SalesRank')
    rank.present? ? rank.first.try(:children).try(:text).match(/(#)\d+\s[\w\s]+/)[0].rstrip! : nil
  end

  # Search for dimensions by CSS
  def self.dimensions(data)
    dimensions = data.css('.size-weight+ .size-weight .value')
    dimensions.present? ? dimensions.try(:children).try(:text) : nil
  end
end

