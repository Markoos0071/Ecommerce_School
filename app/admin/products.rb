ActiveAdmin.register Product do

  permit_params :name, :description, :price, :category_id, :image, :remove_image

  filter :name
  filter :description
  filter :price
  filter :category

  form do |f|
    f.inputs "Product Details" do
      f.input :name
      f.input :price
      f.input :description
      f.input :image, as: :file
      f.input :remove_image, as: :boolean, label: 'Remove Image'
    end
    f.actions
  end

end
