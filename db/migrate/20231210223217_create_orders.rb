class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.decimal :total_cost, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
