class AddAutomaticPausesToShop < ActiveRecord::Migration
  def change
    add_column :shops, :automatic_pauses, :boolean
  end
end
