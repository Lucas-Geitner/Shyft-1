class RemoveTimesFromShops < ActiveRecord::Migration
  def change
    remove_column :shops, :opening_time, :integer
    remove_column :shops, :closing_time, :integer
  end
end
