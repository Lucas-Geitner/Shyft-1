class AddGroupNameToOrganisation < ActiveRecord::Migration
  def change
    add_column :organisations, :group_name, :string
  end
end
