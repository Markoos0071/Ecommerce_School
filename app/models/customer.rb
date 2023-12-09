class Customer < ApplicationRecord
  has_many :orders, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "id", "name", "updated_at"]
  end
end
