class TypeOfEngine < ActiveRecord::Base
	self.table_name = "type_of_engine"
	#self.primary_key = "ID"
	has_many :engines
end
