class AddPriceToSpecifications < ActiveRecord::Migration
  def change
	add_column :specifications, :PRICE, :integer
  end
end
