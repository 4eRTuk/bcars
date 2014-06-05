class Engine < ActiveRecord::Base
	self.table_name = "engine"
	#self.primary_key = "ID"
	has_and_belongs_to_many :specifications, :join_table => "specs_engines"
	belongs_to :type_of_engine, :foreign_key => "typeofengine_id"
end
