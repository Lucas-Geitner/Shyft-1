class AddConventionToOrganisation < ActiveRecord::Migration
  def change
    add_reference :organisations, :convention, index: true, foreign_key: true
  end
end
