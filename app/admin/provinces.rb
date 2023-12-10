ActiveAdmin.register Province do

  permit_params :name, :pst_rate, :hst_rate, :gst_rate

  index do
    selectable_column
    id_column
    column :name
    column :pst_rate
    column :hst_rate
    column :gst_rate
    actions
  end

  filter :name
  filter :pst_rate
  filter :hst_rate
  filter :gst_rate

  form do |f|
    f.inputs 'Province Details' do
      f.input :name
      f.input :pst_rate
      f.input :hst_rate
      f.input :gst_rate
    end
    f.actions
  end
end
