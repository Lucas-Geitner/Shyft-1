class AddTimesToShops < ActiveRecord::Migration
  def change
    add_column :shops, :opening_time, :datetime
    add_column :shops, :closing_time, :datetime
  end
end
