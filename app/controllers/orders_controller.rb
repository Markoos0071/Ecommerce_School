class OrdersController < ApplicationController
  def index
    @orders = Order.where(user_id: current_user.id).includes(:order_items).order(created_at: :desc)
  end
end
