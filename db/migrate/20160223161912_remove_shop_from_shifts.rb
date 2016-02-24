class RemoveShopFromShifts < ActiveRecord::Migration
  def change
    remove_column :shifts, :shop_id
  end
end
