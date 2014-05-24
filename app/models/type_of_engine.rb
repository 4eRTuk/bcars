class TypeOfEngine < ActiveRecord::Base
	self.table_name = "TYPE_OF_ENGINE"
	self.primary_key = "ID"
	has_many :engines
end
