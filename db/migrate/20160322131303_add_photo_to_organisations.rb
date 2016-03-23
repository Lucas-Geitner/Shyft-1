class AddPhotoToOrganisations < ActiveRecord::Migration
  def change
    add_column :organisations, :photo, :string
  end
end
