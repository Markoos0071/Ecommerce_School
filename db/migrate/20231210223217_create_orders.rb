class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.decimal :total_cost, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end

    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 0
      t.decimal :unit_cost, precision: 8, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
