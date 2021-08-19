class CreateOrderInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :order_infos do |t|
      t.integer :customer_id, null: false
      t.integer :postage, null: false
      t.integer :total_payment, null: false
      t.integer :payment_method, null: false
      t.integer :order_status, null: false, default: 0
      t.string  :postal_code, null: false
      t.string  :address, null: false
      t.string  :name, null: false

      t.timestamps
    end
    add_foreign_key :order_infos, :customers
  end
end
