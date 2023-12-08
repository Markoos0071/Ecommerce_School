class Order < ApplicationRecord
  belongs_to :customer

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "customer_id", "id", "province", "total", "updated_at"]
  end
end
