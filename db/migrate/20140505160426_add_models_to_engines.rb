class AddModelsToEngines < ActiveRecord::Migration
  def change
	create_table :SPECS_ENGINES, id: false do |t|
      t.belongs_to :specification
      t.belongs_to :engine
    end
  end
end
