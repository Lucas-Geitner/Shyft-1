class AddShopNameToOrganisation < ActiveRecord::Migration
  def change
    add_column :organisations, :shop_name, :string
  end
end
