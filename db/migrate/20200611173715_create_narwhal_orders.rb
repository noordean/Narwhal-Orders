class CreateNarwhalOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :narwhal_orders do |t|
      t.string :name
      t.string :customer
      t.string :order_id

      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
