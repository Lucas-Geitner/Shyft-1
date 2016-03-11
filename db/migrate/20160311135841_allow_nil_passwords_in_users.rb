class AllowNilPasswordsInUsers < ActiveRecord::Migration
  def change
    # Allow null encrypted_password
    change_column :users, :encrypted_password, :string, :null => true
    change_column :users, :invitation_token, :string, :limit => nil
  end
end
