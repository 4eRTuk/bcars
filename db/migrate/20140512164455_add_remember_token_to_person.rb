class AddRememberTokenToPerson < ActiveRecord::Migration
  def change
	add_column :person, :remember_token, :string
	add_index  :person, :remember_token
  end
end
