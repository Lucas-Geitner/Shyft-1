class AddOrganisationToShops < ActiveRecord::Migration
  def change
    add_reference :shops, :organisation, index: true, foreign_key: true
  end
end
