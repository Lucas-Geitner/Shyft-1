class CreatePostes < ActiveRecord::Migration
  def change
    create_table :postes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
