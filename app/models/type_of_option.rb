class TypeOfOption < ActiveRecord::Base
	self.table_name = "TYPE_OF_OPTION"
	self.primary_key = "ID"
	has_many :options
end
