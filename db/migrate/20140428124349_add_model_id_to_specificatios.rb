class AddModelIdToSpecificatios < ActiveRecord::Migration
  def change
    add_column :specifications, :MODEL_ID, :integer
  end
end
