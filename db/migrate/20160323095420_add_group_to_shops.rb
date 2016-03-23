class AddGroupToShops < ActiveRecord::Migration
  def change
    add_reference :shops, :group, index: true, foreign_key: true
  end
end
