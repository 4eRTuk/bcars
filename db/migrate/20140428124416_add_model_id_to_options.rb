class AddModelIdToOptions < ActiveRecord::Migration
  def change
    add_column :options, :MODEL_ID, :integer
  end
end
