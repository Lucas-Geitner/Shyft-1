class AddTypeToPoste < ActiveRecord::Migration
  def change
    add_column :postes, :type, :string
  end
end
