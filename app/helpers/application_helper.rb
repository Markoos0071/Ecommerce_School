module ApplicationHelper
  def in_cart?(product)
    session[:cart]&.include?(product.id)
  end
end
