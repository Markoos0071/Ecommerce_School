ActiveAdmin.register User do

  permit_params :username, :email, :encrypted_password, :province_id

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :province
    actions
  end

  filter :username
  filter :email
  filter :province, as: :select, collection: Province.all

  form do |f|
    f.inputs 'User Details' do
      f.input :username
      f.input :email
      f.input :encrypted_password
      f.input :province
    end
    f.actions
  end
end
