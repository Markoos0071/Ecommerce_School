class Address < ApplicationRecord
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    ["city", "created_at", "id", "postal_code", "street_address", "updated_at", "user_id"]
  end
end
