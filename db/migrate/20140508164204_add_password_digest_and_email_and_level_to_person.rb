class AddPasswordDigestAndEmailAndLevelToPerson < ActiveRecord::Migration
  def change
    add_column :person, :password_digest, :string
    add_column :person, :email, :string, :limit => 320
    add_column :person, :acs_level, :integer, :default => 0, :null => false
  end
end
