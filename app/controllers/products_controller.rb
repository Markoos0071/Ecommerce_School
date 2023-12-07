class ProductsController < ApplicationController
  def index
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

      @filtered_products = @filtered_products.page(params[:page]).per(15)
    end

  end

  def show
    @product = Product.find(params[:id])
  end
end
