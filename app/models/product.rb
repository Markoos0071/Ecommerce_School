class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items

  def self.search(category, keyword)
    products = all
    products = products.where(category: category) if category.present?

    if keyword.present?
      search_results = products.ransack(name_or_description_cont: keyword).result
      products = search_results
    end

    products
  end

  attr_accessor :remove_image
  before_save :remove_image_if_requested
  private

  def remove_image_if_requested
    self.image = nil if remove_image == '1' || remove_image == true
  end

  attr_accessor :image_attachment_id_filter

  def self.ransackable_attributes(auth_object = nil)
    super + ['image_attachment_id_filter']
  end

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "name", "price", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
    end
end
