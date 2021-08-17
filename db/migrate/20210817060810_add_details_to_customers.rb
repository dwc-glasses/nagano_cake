class AddDetailsToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :family_name, :string
    add_column :customers, :given_name, :string
    add_column :customers, :family_name_kana, :string
    add_column :customers, :given_name_kana, :string
    add_column :customers, :phone, :string
    add_column :customers, :suspended, :boolean, default: false
    add_column :customers, :postal_code, :string
    add_column :customers, :address, :string
  end
end
