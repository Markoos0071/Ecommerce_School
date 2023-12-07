class ProductsController < ApplicationController
  def index
    @selected_filter = params[:filter] || 'new'

    case @selected_filter
    when 'new'
      @filtered_products = Product.where('created_at >= ?', 3.days.ago).order(created_at: :desc).page(params[:page]).per(15)
    when 'recently_updated'
      @filtered_products = Product.where('updated_at >= ? AND created_at < ?', 3.days.ago, 3.days.ago).order(updated_at: :desc).page(params[:page]).per(15)
    else
      @filtered_products = Product.where('created_at >= ?', 3.days.ago).order(created_at: :desc).page(params[:page]).per(15)
      @selected_filter = 'new'
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
