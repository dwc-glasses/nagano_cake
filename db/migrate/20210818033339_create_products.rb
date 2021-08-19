class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.references :genre, null: false
      t.integer :price, null: false
      t.string :image_id, null: false
      t.boolean :sales_status, null: false, default: true
      
      t.timestamps
    end
  end
end
