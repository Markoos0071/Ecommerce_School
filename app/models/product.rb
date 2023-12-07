class Product < ApplicationRecord
  belongs_to :category

  def self.search(category, keyword)
    products = all
    products = products.where(category: category) if category.present?

    if keyword.present?
      search_results = products.ransack(name_or_description_cont: keyword).result
      products = search_results
    end

    products
  end

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "name", "price", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
    end
end
