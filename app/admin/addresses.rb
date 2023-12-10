ActiveAdmin.register Address do

  permit_params :street_address, :city, :postal_code, :user_id

end
