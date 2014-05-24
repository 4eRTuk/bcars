class AddPhoneToPersonsAndStatusToOrders < ActiveRecord::Migration
  def change
    add_column :person, :phone, :string, :limit => 11
    add_column :orders, :status_id, :integer, :default => 0
	
	create_table :STATUSES do |t|
      t.string "STATUS"
    end
  end
end
