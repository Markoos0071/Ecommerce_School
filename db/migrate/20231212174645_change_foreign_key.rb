class ChangeForeignKey < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :orders, :customers
    add_foreign_key :orders, :users
  end
end
