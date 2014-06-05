class TypeOfOption < ActiveRecord::Base
	self.table_name = "type_of_option"
	#self.primary_key = "ID"
	has_many :options
end
