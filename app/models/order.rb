class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "total_cost", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["order_items", "products", "user"]
  end
end
