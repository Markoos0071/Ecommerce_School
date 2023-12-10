class Province < ApplicationRecord
  has_many :users

  validates :name, presence: true, uniqueness: true

  validates :pst_rate, :gst_rate, :hst_rate, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at", "pst_rate", "hst_rate", "gst_rate"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["users"]
  end
end
