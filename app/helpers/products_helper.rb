module ProductsHelper
  def display_field(attribute)
    attribute.present? ? attribute : 'Not found'
  end
end
