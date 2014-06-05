class AddImageToModel < ActiveRecord::Migration
  def change
	add_column :models, :iname, :string
	add_column :models, :data, :binary
	add_column :models, :filename, :string
	add_column :models, :mime_type, :string
  end
end
