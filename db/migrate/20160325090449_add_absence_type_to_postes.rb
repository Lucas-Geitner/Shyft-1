class AddAbsenceTypeToPostes < ActiveRecord::Migration
  def change
    add_column :postes, :absence_type, :string
  end
end
