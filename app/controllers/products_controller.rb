class ProductsController < ApplicationController
  before_action :load_cart, only: [:cart]

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
    session[:cart] << product.id
    redirect_back(fallback_location: root_path)
  end

  def remove_from_cart
    product = Product.find(params[:id])
    session[:cart]&.delete(product.id)
    redirect_back(fallback_location: root_path)
  end

  def cart
    @cart_products = Product.where(id: @cart)
  end

  private

  def load_cart
    @cart = session[:cart] || []
  end
end
