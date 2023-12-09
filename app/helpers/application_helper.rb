module ApplicationHelper
  def in_cart?(product)
    session[:cart].present? && session[:cart].any? { |item| item['id'] == product.id }
  end

end
