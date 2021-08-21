class CreateCartProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_products do |t|
      t.references :customer, null: false
      t.references :product, null: false
      t.integer :quantity, null:false

      t.timestamps
    end
  end
end
