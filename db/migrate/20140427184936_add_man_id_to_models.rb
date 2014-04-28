class AddManIdToModels < ActiveRecord::Migration
  def change
    add_column :models, :MANUFACTURER_ID, :integer
  end
end
