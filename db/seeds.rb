# require 'faker'

# # Create categories
# 4.times do
#   Category.create(name: Faker::Commerce.department)
# end

# # Create products
# 100.times do
#   product = Product.create(
#     name: Faker::Commerce.product_name,
#     description: Faker::Lorem.sentence,
#     price: Faker::Commerce.price,
#     category_id: Category.pluck(:id).sample
#   )
# end

#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?