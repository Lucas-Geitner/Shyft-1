class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :shop, index: true, foreign_key: true
      t.string :role

      t.timestamps null: false
    end
  end
end
