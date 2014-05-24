class AddColorToCars < ActiveRecord::Migration
  def change
    add_column :cars, :color, :string, :limit => 7
  end
end
