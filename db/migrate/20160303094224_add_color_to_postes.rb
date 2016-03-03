class AddColorToPostes < ActiveRecord::Migration
  def change
    add_column :postes, :color, :string
  end
end
