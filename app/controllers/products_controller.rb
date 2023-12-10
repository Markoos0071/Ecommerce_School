class ProductsController < ApplicationController
  before_action :load_cart, only: [:cart, :checkout]
  helper_method :session_cart_quantity

  def index
    @selected_filter = params[:filter] || 'all'
    @selected_category = params[:category]
    @search = params[:search]

    @filtered_products = Product.all

    @filtered_products = @filtered_products.where(category: @selected_category) if @selected_category.present?

    @filtered_products = @filtered_products.ransack(name_or_description_cont: @search).result if @search.present?

    case @selected_filter
    when 'new'
      @filtered_products = @filtered_products.where('created_at >= ?', 3.days.ago).order(created_at: :desc)
    when 'recently_updated'
      @filtered_products = @filtered_products.where('updated_at >= ?', 1.days.ago).order(updated_at: :desc)
    end

    @filtered_products = @filtered_products.page(params[:page]).per(15) if @filtered_products

  end

  def show
    @product = Product.find(params[:id])
  end


  def add_to_cart
    product = Product.find(params[:id])
    session[:cart] ||= []
    cart_item = session[:cart].find { |item| item['id'] == product.id }

    if cart_item
      cart_item['quantity'] += 1
    else
      session[:cart] << { 'id' => product.id, 'quantity' => 1 }
    end

    redirect_back(fallback_location: root_path)
  end

  def update_cart
    product = Product.find(params[:id])
    quantity = params[:quantity].to_i

    if quantity.positive?
      session[:cart].find { |item| item['id'] == product.id }['quantity'] = quantity
    else
      session[:cart].delete_if { |item| item['id'] == product.id }
    end

    redirect_to cart_products_path
  end

  def remove_from_cart
    product_id = params[:id]
    session[:cart]&.delete_if { |item| item['id'] == product_id.to_i }
    redirect_back(fallback_location: root_path)
  end


  def cart
    @cart_products = Product.where(id: @cart.map { |item| item['id'] })
    @total_amount = calculate_total_amount(@cart_products)
    @provinces = ['Ontario', 'Quebec', 'British Columbia', 'Alberta', 'Manitoba', 'Saskatchewan', 'Nova Scotia', 'New Brunswick', 'Newfoundland and Labrador', 'Prince Edward Island']

    if request.post?
      # Process the checkout
      customer = create_or_find_customer(params[:customer])
      order = create_order(customer, @cart_products, @total_amount)
      province = params[:customer][:province]
      tax_rates = Province.find_by(name: province)&.tax_rates
      pst = @total_amount * tax_rates.pst_rate
      gst = @total_amount * tax_rates.gst_rate
      hst = @total_amount * tax_rates.hst_rate

      total_with_taxes = @total_amount + pst + gst + hst


      # Clear the cart after successful checkout
      session[:cart] = []

      redirect_to order_path(order)
    end
  end


  def checkout
    @cart_products = Product.where(id: @cart.map { |item| item['id'] })
    @total_amount = calculate_total_amount(@cart_products)
    @provinces = ['Ontario', 'Quebec', 'British Columbia', 'Alberta', 'Manitoba', 'Saskatchewan', 'Nova Scotia', 'New Brunswick', 'Newfoundland and Labrador', 'Prince Edward Island']

    if request.post?
      # Process the checkout
      customer = create_or_find_customer(params[:customer])
      order = create_order(customer, @cart_products, @total_amount)
      province = params[:customer][:province]
      tax_rates = Province.find_by(name: province)&.tax_rates
      pst = @total_amount * tax_rates.pst_rate
      gst = @total_amount * tax_rates.gst_rate
      hst = @total_amount * tax_rates.hst_rate

      total_with_taxes = @total_amount + pst + gst + hst


      # Clear the cart after successful checkout
      session[:cart] = []

      redirect_to order_path(order)
    end
  end

  def session_cart_quantity(product_id)
    cart_item = session[:cart].find { |item| item['id'] == product_id.to_i }
    cart_item ? cart_item['quantity'].to_i : 0
  end

  private

  def calculate_total_amount(cart_products)
    cart_products.sum { |product| product.price * session_cart_quantity(product.id) }
  end

  def load_cart
    @cart = session[:cart] || []
  end
end
