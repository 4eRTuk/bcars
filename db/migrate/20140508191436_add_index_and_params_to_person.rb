class AddIndexAndParamsToPerson < ActiveRecord::Migration
  def change
    change_column :person, :password_digest, :string, :null => false
    change_column :person, :email, :string, :limit => 320, :null => false, :unique => true
    add_index :person, :email, unique: true
  end
end
