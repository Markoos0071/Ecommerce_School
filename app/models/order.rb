class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "customer_id", "id", "province", "total", "updated_at"]
  end
end
