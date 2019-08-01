class Scraper
  require 'httparty'
  require 'nokogiri'

  def self.fetch_data(url)
    # setting user agent so prevent requests being blocked by Amazon
    headers = {
      "User-Agent": 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/601.5.17 (KHTML, like Gecko) Version/9.1 Safari/601.5.17'
    }
    response = HTTParty.get(url, headers: headers)
    case response.code
    when 200
      Nokogiri::HTML(response)
    when 404
      return 'webpage not found'
    when 500...600
      return 'server error'
    end
  end

  # specify URL to making API call to
  def self.get_product_info(asin)
    url = "https://www.amazon.com/dp/#{asin}"
    response = fetch_data(url)
    if response.include? 'webpage not found'
      return response
    elsif response.include? 'server error'
      return response
    end

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
    name.present? ? name.first.try(:children).try(:text).try(:lstrip!).try(:rstrip!).try(:squish) : nil
  end

  # Search for category by CSS
  def self.category(data)
    category = data.css('.a-color-tertiary')
    category.present? ? category.first.try(:children).try(:text).try(:lstrip!).try(:rstrip!).try(:squish) : nil
  end

  # Search for rank by different CSS selectors
  def self.rank(data)
    if data.css('#SalesRank').present?
      rank = data.css('#SalesRank').first.try(:text).match(/(#)[\d,]+\sin\s[\w\s,&]+/)
      rank.present? ? rank[0].rstrip! : nil
    elsif data.css('#prodDetails').present?
      rank = data.css('#prodDetails').try(:text).match(/(#)[\d,]+\sin\s[\w\s&]+/)
      rank.present? ? rank[0].rstrip! : nil
    elsif data.css('#descriptionAndDetails').present?
      rank = data.css('#descriptionAndDetails').match(/(#)[\d,]+\sin\s[\w\s&]+/)
      rank.present? ? rank[0].rstrip! : nil
    end
  end

  # Search for dimensions by different CSS selectors
  def self.dimensions(data)
    if data.css('.size-weight+ .size-weight .value').present?
      data.css('.size-weight+ .size-weight .value').try(:children).try(:text)
    elsif data.css('#prodDetails').present?
      dimensions = data.css('#prodDetails').try(:text).match(/[\d\."']+\sx\s[\d\."']+\sx\s[\d\."']+\s\w+/)
      dimensions.present? ? dimensions[0] : nil
    elsif data.css('#descriptionAndDetails').present?
      dimensions = data.css('#descriptionAndDetails').try(:text).match(/[\d\."']+\sx\s[\d\."']+\sx\s[\d\."']+\s\w+/)
      dimensions.present? ? dimensions[0] : nil
    end
  end
end

