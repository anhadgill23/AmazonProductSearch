module ProductsHelper
  def check_for_nil(attribute)
    attribute.present? ? attribute : 'Not found'
  end
end
